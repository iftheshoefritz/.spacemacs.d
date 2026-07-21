;;; itsf-org-gcal-core.el --- shared org-gcal setup -*- lexical-binding: t -*-
;; Loaded by BOTH ~/.spacemacs (interactive) and the background fetch child
;; (itsf/org-gcal-fetch-background). Keep only batch-safe, non-interactive
;; setup here so the two never drift; interactive bits (gcal: link, capture
;; helpers, the fetch commands) stay in ~/.spacemacs.

(require 'auth-source)

;; Machine-local values (personal email + calendar file paths) live in a
;; gitignored org-gcal-local.el next to this file, so nothing personal is
;; committed. It must set `itsf/org-gcal-encrypt-to' and
;; `itsf/org-gcal-fetch-file-alist'. See org-gcal-local.el.example.
(defvar itsf/org-gcal-encrypt-to nil
  "Email/GPG recipient for `plstore-encrypt-to'. Set in org-gcal-local.el.")
(defvar itsf/org-gcal-fetch-file-alist nil
  "Alist of (CALENDAR-ID . ORG-FILE) for org-gcal. Set in org-gcal-local.el.")

(let ((local (expand-file-name
              "org-gcal-local.el"
              (file-name-directory (or load-file-name buffer-file-name)))))
  (if (file-exists-p local)
      (load local)
    (warn "org-gcal-core: %s not found; copy org-gcal-local.el.example to it"
          local)))

(setq plstore-encrypt-to itsf/org-gcal-encrypt-to)
(setq oauth2-auto-plstore (expand-file-name "oauth2-auto.plist" user-emacs-directory))

(let* ((creds (car (auth-source-search :host "org-gcal" :require '(:user :secret))))
       (client-id (plist-get creds :user))
       (client-secret (funcall (plist-get creds :secret))))
  (setq org-gcal-client-id client-id
        org-gcal-client-secret client-secret
        org-gcal-fetch-file-alist itsf/org-gcal-fetch-file-alist))

(require 'org-gcal)
(org-gcal-reload-client-id-secret)
(setq org-gcal-notify-p nil)
(setq org-gcal-remove-api-cancelled-events t) ; auto-remove cancelled events, no prompt
(setq org-gcal-auto-archive nil)              ; archive separately, not on the fetch hot path

(defun itsf/org-gcal-set-scheduled-from-event (calendar-id event _update-mode)
  "Set SCHEDULED timestamp from EVENT so org-alert can fire notifications.
org-gcal only updates SCHEDULED if it already exists on the entry; this hook
ensures it is always set so that org-alert's SCHEDULED-matching regex fires.
Duplicate agenda entries from the :org-gcal: drawer timestamp are prevented
by the file-local `org-agenda-entry-types' in calendar.org excluding :timestamp."
  (condition-case err
      (let* ((stime (plist-get (plist-get event :start) :dateTime))
             (etime (plist-get (plist-get event :end)   :dateTime))
             (sday  (plist-get (plist-get event :start) :date))
             (eday  (plist-get (plist-get event :end)   :date))
             (start (if stime
                        (org-gcal--convert-time-to-local-timezone stime org-gcal-local-timezone)
                      sday))
             (end   (if etime
                        (org-gcal--convert-time-to-local-timezone etime org-gcal-local-timezone)
                      eday)))
        (when start
          (let ((timestamp
                 (if (or (string= start end) (org-gcal--alldayp start end))
                     (org-gcal--format-iso2org start)
                   (if (and
                        (= (plist-get (org-gcal--parse-date start) :year)
                           (plist-get (org-gcal--parse-date end)   :year))
                        (= (plist-get (org-gcal--parse-date start) :mon)
                           (plist-get (org-gcal--parse-date end)   :mon))
                        (= (plist-get (org-gcal--parse-date start) :day)
                           (plist-get (org-gcal--parse-date end)   :day)))
                       (format "<%s-%s>"
                               (org-gcal--format-date start "%Y-%m-%d %a %H:%M")
                               (org-gcal--format-date end "%H:%M"))
                     (format "%s--%s"
                             (org-gcal--format-iso2org start)
                             (org-gcal--format-iso2org
                              (if (< 11 (length end))
                                  end
                                (org-gcal--iso-previous-day end))))))))
            (let ((org-closed-keep-when-no-todo t))
              (org-schedule nil timestamp)))))
    (error (message "itsf/org-gcal-set-scheduled-from-event error: %S" err))))
(add-to-list 'org-gcal-after-update-entry-functions
             #'itsf/org-gcal-set-scheduled-from-event)

(defun itsf/org-gcal-prune-fetch-window ()
  "Delete org-gcal-managed entries whose SCHEDULED time is in the fetch window.
Run in the background fetch child immediately before `org-gcal-sync', which is
forced to a FULL (tokenless) sync. A full list request from Google only ever
returns *live* events — it never reports a cancellation or deletion (those
arrive solely as syncToken deltas). So org-gcal's full sync can add and update
but can never prune, and events cancelled in Google linger in the file forever.

Wiping the window first turns the full sync into a true replace: everything in
[now - `org-gcal-up-days', now + `org-gcal-down-days'] is deleted, then the
sync re-inserts exactly the events Google still considers live. A cancelled
event is gone because nothing re-creates it. The wipe is scoped to the fetch
window on purpose — entries outside it (past events awaiting archive, far-future
events the fetch won't return) are left untouched so their `gcal:' links keep
resolving. entry-id values are deterministic from the Google event id, so links
into re-inserted in-window events keep resolving too."
  (let ((up   (org-gcal--up-time))
        (down (org-gcal--down-time)))
    (dolist (cal org-gcal-fetch-file-alist)
      (with-current-buffer (find-file-noselect (expand-file-name (cdr cal)))
        (org-with-wide-buffer
         (let ((markers nil))
           (org-map-entries
            (lambda ()
              (when (string= (org-entry-get (point) org-gcal-managed-property)
                             "gcal")
                (let ((sched (org-get-scheduled-time (point))))
                  (when (and sched
                             (not (time-less-p sched up))
                             (not (time-less-p down sched)))
                    (push (point-marker) markers)))))
            nil 'file)
           ;; Delete bottom-up so earlier headings' positions stay valid.
           (dolist (m (sort markers
                            (lambda (a b) (> (marker-position a)
                                             (marker-position b)))))
             (goto-char m)
             (org-cut-subtree))))))))

;; Workaround for https://github.com/rhaps0dy/emacs-oauth2-auto/issues/6
(defun oauth2-auto--insert-break-on-secret-entries (&rest _args) nil)

(provide 'itsf-org-gcal-core)
;;; itsf-org-gcal-core.el ends here
