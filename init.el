;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(go
     ansible
     (rust :variables
           lsp-rust-analyzer-cargo-auto-reload t)
     react
     clojure
     elm
     (prettier :variables
               prettier-js-command "prettier"
               )
     (typescript :variables
                 ;;typescript-fmt-on-save t
                 typescript-fmt-tool 'prettier
                 typescript-linter 'eslint
                 typescript-backend 'lsp
                 typescript-lsp-linter nil
                 typescript-indent-level 2
                 )
     (lsp :variables
          lsp-ui-doc-enable nil
          ;;lsp-log-io t
          lsp-enable-file-watchers t
          lsp-file-watch-threshold 5000
          lsp-lens-enable t
          lsp-headerline-breadcrumb-enable t
          lsp-modeline-code-actions-enable t
          ;;lsp-solargraph-log-level "info"
          ;;lsp-solargraph-multi-root nil
          ;;lsp-solargraph-use-bundler nil
          lsp-disabled-clients '(flow-ls)
          )
     yaml
     (javascript :variables
                 javascript-backend 'lsp
                 javascript-fmt-tool 'prettier
                 js2-basic-offset 2
                 js-indent-level 2
                 js2-strict-missing-semi-warning nil
                 )
     (html :variables
           web-fmt-tool 'prettier)
     emacs-lisp
     (git :variables
          git-enable-magit-delta-plugin t)
     (helm :variables
           helm-ag-command-option "--sort path"
           )
     markdown
     multiple-cursors
     (org  :variables
           org-enable-roam-support t
           ;; Overridden in dotspacemacs/user-config from `itsf/org-roam-directory'
           ;; (paths-local.el); this is just a generic default for layer load time.
           org-roam-directory "~/org-roam-notes"
           org-enable-notifications t
           org-start-notification-daemon-on-startup t
           )
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'ghostel
            shell-default-term-shell "/bin/zsh"
            )
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     ;; spell-checking
     syntax-checking
     treemacs
     (version-control :variables
                      version-control-diff-tool 'diff-hl
                      version-control-diff-side 'right
                      version-control-global-margin t)
     graphviz
     python
     csv
     (ruby :variables
           ;;ruby-backend 'lsp
           ruby-backend 'robe
           ruby-enable-ruby-on-rails-support t
           ;;ruby-enable-enh-ruby-mode t
           ruby-test-runner 'rspec
           ;;ruby-version-manager 'rbenv
           ruby-prettier-on-save nil
           )
     ruby-on-rails
     sql
     erc
     command-log
     dap
     auto-completion
     (vue :variables vue-backend 'lsp)
     (spacemacs-layouts :variables
                        persp-autokill-buffer-on-remove 'kill-weak
                        )
     mermaid
     ;; Folding only, for now. Emacs 30.2 ships no `ruby-mode' entry in
     ;; `hs-special-modes-alist', so hideshow — and therefore evil's zc/zo —
     ;; can fold paren sexps but not do/end, def/end or class/end in Ruby.
     ;; ts-fold folds on the tree-sitter parse tree instead, and registers
     ;; itself in `evil-fold-list' on activation, so zc just works.
     ;;
     ;; This is elisp-tree-sitter (a minor mode over `ruby-mode'), NOT built-in
     ;; treesit: it leaves the major mode alone, so robe, rspec, rubocop and the
     ;; ruby-on-rails layer — all of which hook `ruby-mode-hook' by name — keep
     ;; working. `ruby-ts-mode' would silently lose the lot, because it derives
     ;; from `ruby-base-mode', not `ruby-mode' (ruby-ts-mode.el:1151).
     ;;
     ;; Syntax highlighting is left off deliberately: adopt folding first and
     ;; see whether tree-sitter-hl fights lsp-mode's font-lock before enabling
     ;; it. Turn it on with `tree-sitter-syntax-highlight-enable' when ready.
     (tree-sitter :variables
                  tree-sitter-fold-enable t
                  tree-sitter-syntax-highlight-enable nil)
     (llm-client :variables
                 llm-client-enable-gptel t)
     claude-code
     )


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      mcp
                                      keychain-environment
                                      ellama
                                      (code-review :location (recipe :fetcher github
                                                                     :repo "doomelpa/code-review"
                                                                     :commit "303edcfbad8190eccb9a9269dfc58ed26d386ba5"))
                                      (opencode :location (recipe
                                                           :fetcher github
                                                           :repo "colobas/opencode.el"
                                                           :branch "main"
                                                           :files ("*.el")))
                                      org-gcal
                                      async
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The maximum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "nerd-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light). A theme from external
   ;; package can be defined with `:package', or a theme can be defined with
   ;; `:location' to download the theme package, refer the themes section in
   ;; DOCUMENTATION.org for the full theme specifications.
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for `default' and
   ;; `fixed-pitch' faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 15.0
                               :weight normal
                               :width normal)

   ;; Default icons font, it can be `all-the-icons' or `nerd-icons'.
   dotspacemacs-default-icons-font 'all-the-icons

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "M-<return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key "M-<return>"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Make consecutive tab key presses after commands such as
   ;; `spacemacs/alternate-buffer' (SPC TAB) cycle through previous
   ;; buffers/windows/etc. Please see the option's docstring for more information.
   ;; Set the option to t in order to enable cycling for all current and
   ;; future cycling commands. Alternatively, choose a subset of the currently
   ;; supported commands: '(alternate-buffer alternate-window). (default nil)
   dotspacemacs-enable-cycling nil

   ;; Whether side windows (such as those created by treemacs or neotree)
   ;; are kept or minimized by `spacemacs/toggle-maximize-window' (SPC w m).
   ;; (default t)
   dotspacemacs-maximize-window-keep-side-windows t

   ;; If nil, no load-hints enabled. If t, enable the `load-hints' which will
   ;; put the most likely path on the top of `load-path' to reduce walking
   ;; through the whole `load-path'. It's an experimental feature to speedup
   ;; Spacemacs on Windows. Refer the FAQ.org "load-hints" session for details.
   dotspacemacs-enable-load-hints nil

   ;; If non-nil, enable the `package-quickstart' feature to avoid activating
   ;; all package autoloads one by one.
   ;; Requires building and maintaining a quickstart autoload file for all
   ;; installed packages.
   ;; Refer to the FAQ.org "package-quickstart" section for details.
   ;; (default nil)
   dotspacemacs-enable-package-quickstart nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols 'display-graphic-p

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'.
   ;; Only effective when `dotspacemacs-activate-smartparens-mode' is non-nil.
   ;; Redundant when `smartparens-strict-mode' is enabled. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `ack' and `grep'.
   ;; (default '("rg" "ag" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; The backend used for undo/redo functionality. Possible values are
   ;; `undo-redo', `undo-fu' and `undo-tree' see also `evil-undo-system'.
   ;; Note that saved undo history does not get transferred when changing
   ;; your undo system from or to undo-tree. (default `undo-redo')
   dotspacemacs-undo-system 'undo-redo

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; The variable `global-spacemacs-whitespace-cleanup-modes' controls
   ;; which major modes have whitespace cleanup enabled or disabled
   ;; by default.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq-default git-magit-status-fullscreen t)
  (setq insert-directory-program (substitute-in-file-name "/usr/local/bin/gls"))
  ;; Keep in step with `brew list --versions gcc` (and ~/bin/emacs-daemon):
  ;; Homebrew deletes the old cellar on a major bump, and this setenv overrides
  ;; whatever the daemon exported.
  (setenv "CC" "/opt/homebrew/bin/gcc-16")
  (setq exec-path-from-shell-arguments '("-l" "-i"))
  (setq evil-want-minibuffer t) ; allow normal/evil mode in minibuffer
  (setq evil-want-Y-yank-to-eol nil)
  ;; `warning-suppress-types' still allows warnings to be written to *Warnings*,
  ;; so the log stays complete; it only stops the window from jumping up. This
  ;; prevents me from being bothered by nativecomp warnings that occur despite
  ;; emacs working correctly.
  (add-to-list 'warning-suppress-types '(native-compiler))
  ;; Redirect auto-generated Customize churn (org-agenda-files,
  ;; package-selected-packages, ...) out of this file and into a gitignored
  ;; custom.el, so the versioned config stays clean and free of private paths.
  ;; Settings we deliberately care about are kept as code below / in user-config.
  (setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
  (when (file-exists-p custom-file) (load custom-file))
  ;; Keep ghostel's native module outside elpa/ so a package upgrade can't delete
  ;; a dylib this Emacs already has mapped. Must be set here rather than in
  ;; `dotspacemacs/user-config': installing/byte-compiling ghostel loads it, and
  ;; `ghostel--load-module' warns against `ghostel--module-directory' at that
  ;; point -- too early for user-config to have redirected it.
  ;; `download' rather than the default `ask' because the daemon has no one to
  ;; answer the prompt.
  (setq ghostel-module-directory (expand-file-name "ghostel-module/" dotspacemacs-directory)
        ghostel-module-auto-install 'download)
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; Machine-local note paths + work context (client name, note dirs) live in a
  ;; gitignored paths-local.el so nothing personal is committed. A committed
  ;; paths-local.el.example provides generic defaults and is loaded as a
  ;; fallback on a fresh clone. Loaded first so later config can use the vars.
  (defvar itsf/org-notes-directory "~/org-notes"
    "Root of the org notes tree. Set in paths-local.el.")
  (defvar itsf/org-roam-directory "~/org-roam-notes"
    "org-roam notes directory. Set in paths-local.el.")
  (defvar itsf/client-notes-file "~/org-notes/work/client/client.org"
    "Current client's notes file. Set in paths-local.el.")
  (defvar itsf/client-agenda-tag "CLIENT"
    "Org tag identifying the current client. Set in paths-local.el.")
  (let* ((paths-local (expand-file-name "paths-local.el" dotspacemacs-directory))
         (paths-example (expand-file-name "paths-local.el.example" dotspacemacs-directory))
         (paths-file (if (file-exists-p paths-local) paths-local paths-example)))
    (when (file-exists-p paths-file)
      (load paths-file)))
  (setq org-roam-directory itsf/org-roam-directory)
  (defun itsf/frame-killer-with-save ()
    "Offer to save modified file-visiting buffers, then close the frame."
    (interactive)
    (save-some-buffers nil (lambda () (and buffer-file-name (buffer-modified-p))))
    (spacemacs/frame-killer))
  (global-set-key (kbd "s-q") #'itsf/frame-killer-with-save)
  (setq org-modules (quote (org-habit)))
  (defun itsf/refresh-org-agenda-files ()
    "Re-scan `itsf/org-notes-directory' for .org files."
    (setq org-agenda-files
          (directory-files-recursively itsf/org-notes-directory "org$")))
  (itsf/refresh-org-agenda-files)
  (run-with-idle-timer 3600 t #'itsf/refresh-org-agenda-files)
  (add-hook 'server-after-make-frame-hook #'itsf/refresh-org-agenda-files)
  (setq create-lockfiles nil)
  (setq js-indent-level 2) ; js-mode
  (setq-default css-indent-offset 2) ; css mode (maybe unnecessary?)
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2) ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2) ; web-mode, js code in html file
  (spacemacs/toggle-display-time-on)
  (define-key evil-normal-state-map (kbd "SPC o b") 'bookmark-set)
  (define-key evil-normal-state-map (kbd "SPC o j") 'bookmark-jump)
  (define-key evil-normal-state-map (kbd "SPC o l") 'evil-ex-nohighlight)
  (spacemacs/declare-prefix-for-mode 'org-mode "mo" "other")
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "oo" 'org-insert-heading-after-current)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "ot" 'org-todo)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "ow" 'browse-url-default-macosx-browser)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "oc" 'my/org-fold-outer)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "od" 'itsf/org-done-current-week-by-tag)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "ob" 'itsf/org-region-to-dashlist-side-buffer)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "oM" 'org-match-closed-to-scheduled)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "be" 'org-babel-execute-src-block)
  ;; Org-capture templates carry personal/work context (client + colleague
  ;; names, note paths), so they live in a gitignored
  ;; org-capture-templates-local.el. A committed
  ;; org-capture-templates-local.el.example provides generic defaults and is
  ;; loaded as a fallback on a fresh clone.
  (let* ((capture-local
          (expand-file-name "org-capture-templates-local.el" dotspacemacs-directory))
         (capture-example
          (expand-file-name "org-capture-templates-local.el.example" dotspacemacs-directory))
         (capture-file (if (file-exists-p capture-local) capture-local capture-example)))
    (if (file-exists-p capture-file)
        (load capture-file)
      (warn "init.el: no org-capture-templates-local.el(.example) found in %s"
            dotspacemacs-directory)))
  (setq org-export-allow-bind-keywords t) ; allow me to add code to org files
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PLANNED(l)" "NEXT(x)" "IN-PROGRESS(p)" "WAITING(w)" "BLOCKED(b)" "|" "DORMANT(m)" "DONE(d)" "NO-ACTION(n)" "STALE(s)")))
  (setq lsp-file-watch-ignored-directories
        '("[/\\\\]ios\\'" "[/\\\\]android\\'" "[/\\\\]\\.git\\'" "[/\\\\]\\.idea\\'" "[/\\\\]\\.eunit\\'" "[/\\\\]node_modules\\'" "[/\\\\]\\.fslckout\\'" "[/\\\\]\\.tox\\'" "[/\\\\]dist\\'" "[/\\\\]dist-newstyle\\'" "[/\\\\]\\.stack-work\\'" "[/\\\\]\\.bloop\\'" "[/\\\\]\\.metals\\'" "[/\\\\]target\\'" "[/\\\\]\\.ccls-cache\\'" "[/\\\\]\\.vscode\\'" "[/\\\\]\\.deps\\'" "[/\\\\]build-aux\\'" "[/\\\\]autom4te.cache\\'" "[/\\\\]\\.reference\\'" "[/\\\\]\\.lsp\\'" "[/\\\\]\\.clj-kondo\\'" "[/\\\\]\\.shadow-cljs\\'" "[/\\\\]\\.babel_cache\\'" "[/\\\\]\\.cpcache\\'" "[/\\\\]bin/Debug\\'" "[/\\\\]obj\\'" "[/\\\\]_opam\\'" "[/\\\\]_build\\'" "[/\\\\]public\\'" "[/\\\\]tmp\\'"))
  ;;(lsp-register-client
  ;; (make-lsp-client :new-connection (lsp-tramp-connection "solargraph")
  ;;                  :major-modes '(ruby-mode)
  ;;                  :remote? t
  ;;                  :server-id 'solargraph-remote
  ;;                  :tramp-remote-path "/workspaces/dev-environment/bin"
  ;;                  ))
  (defun cmp-date-property (prop)
    (let* ((prop prop))
      #'(lambda (a b)
          (let* ((a-pos (get-text-property 0 'org-marker a))
                 (b-pos (get-text-property 0 'org-marker b))
                 (a-date-raw (or (org-entry-get a-pos prop)
                                 (format "<%s>" (org-read-date t nil "now"))))
                 (b-date-raw (or (org-entry-get b-pos prop)
                                 (format "<%s>" (org-read-date t nil "now"))))
                 ;; Parse dates to time values for proper comparison
                 (a-time (org-time-string-to-time a-date-raw))
                 (b-time (org-time-string-to-time b-date-raw)))
            ;; Compare time values: returns negative if a < b, positive if a > b, 0 if equal
            (cond
             ((time-less-p a-time b-time) -1)
             ((time-less-p b-time a-time) 1)
             (t 0))))))
  (defun itsf/capture-agenda-heading ()
    "Extract the heading text from the annotation link stored by org-capture.
Returns the description portion of the [[link][description]] in %a."
    (let ((ann (plist-get org-capture-plist :annotation)))
      (if (and ann (string-match "\\[\\[.*?\\]\\[\\(.*?\\)\\]\\]" ann))
          (match-string 1 ann)
        "")))

  (defun itsf/org-get-scheduled-from-source-event ()
    "Get SCHEDULED timestamp from the item linked in SOURCE_EVENT property.
Resolves gcal: links via entry-id."
    (let ((source-link (org-entry-get nil "SOURCE_EVENT")))
      (when (and source-link
                 (string-match "\\[\\[gcal:\\([^]]+\\)\\]" source-link))
        (let* ((entry-id (match-string 1 source-link))
               (location (org-generic-id-find
                          org-gcal-entry-id-property entry-id)))
          (when location
            (with-current-buffer (find-file-noselect (car location))
              (save-excursion
                (goto-char (cdr location))
                (org-entry-get nil "SCHEDULED"))))))))

  (defun org-match-closed-to-scheduled ()
    (interactive)
    (save-excursion
      (org-back-to-heading t)
      (let* ((scheduled (or (org-entry-get nil "SCHEDULED")
                            (itsf/org-get-scheduled-from-source-event)))
             (has-time (and scheduled
                            (string-match "[0-9]\\{2\\}:[0-9]\\{2\\}" scheduled))))
        (unless scheduled
          (message "No SCHEDULED found locally or via SOURCE_EVENT"))
        (when scheduled
          (let ((end-pos (save-excursion (or (outline-next-heading) (point-max)))))
            (if (re-search-forward "CLOSED: \\[.*?\\]" end-pos t)
                (if has-time
                    (replace-match
                     (format "CLOSED: [%s %s]"
                             (substring scheduled 1 11)
                             (substring scheduled -6 -1))
                     nil nil)
                  (replace-match
                   (format "CLOSED: [%s]" (substring scheduled 1 11))
                   nil nil))
              (message "No CLOSED entry found, cannot update!")))))))

  (defun my/org-fold-outer ()
    (interactive)
    (org-beginning-of-line)
    (if (string-match "^*+" (thing-at-point 'line t))
        (outline-up-heading 1))
    (outline-hide-subtree)
    )

  (defun itsf/org-done-by-tag--week-start-saturday ()
    "Return time for start of current week (Saturday at 00:00:00)."
    (let* ((now (decode-time))
           (dow (nth 6 now)) ; 0=Sun, 1=Mon, ..., 6=Sat
           (days-back (mod (- dow 6) 7)))
      (encode-time 0 0 0
                   (- (nth 3 now) days-back)
                   (nth 4 now)
                   (nth 5 now))))

  (defun itsf/org-done-by-tag--get-filetags ()
    "Get filetags for current buffer."
    (let ((filetags-line
           (save-excursion
             (goto-char (point-min))
             (when (re-search-forward "^#\\+FILETAGS:\\s-*\\(.*\\)$" nil t)
               (match-string-no-properties 1)))))
      (when filetags-line
        (split-string filetags-line ":" t))))

  (defun itsf/org-done-current-week-by-tag ()
    "Display DONE items from current buffer for current week, grouped by tag.

Items are grouped by all their tags (including inherited tags).
Each item appears under every tag it has.
Filetags are excluded from the grouping.
Week starts on Saturday."
    (interactive)
    (let* ((source-buffer (current-buffer))
           (filetags (itsf/org-done-by-tag--get-filetags))
           (week-start (itsf/org-done-by-tag--week-start-saturday))
           (week-end (time-add week-start (days-to-time 7)))
           (tag-items (make-hash-table :test 'equal)))

      ;; Collect all DONE items closed this week
      (with-current-buffer source-buffer
        (org-map-entries
         (lambda ()
           (let* ((closed-str (org-entry-get nil "CLOSED"))
                  (closed-time (and closed-str
                                    (org-time-string-to-time closed-str)))
                  (heading (org-get-heading t t t t))
                  (all-tags (org-get-tags))
                  (tags (seq-difference all-tags filetags)))
             (when (and closed-time
                        (not (time-less-p closed-time week-start))
                        (time-less-p closed-time week-end))
               (if tags
                   ;; Add heading under each of its tags (case-insensitive)
                   (dolist (tag tags)
                     (let ((tag-key (downcase tag)))
                       (puthash tag-key
                                (cons heading (gethash tag-key tag-items '()))
                                tag-items)))
                 ;; No tags - put under "untagged"
                 (puthash "untagged"
                          (cons heading (gethash "untagged" tag-items '()))
                          tag-items)))))
         "/DONE"
         'file))

      ;; Display results
      (let ((output-buffer (get-buffer-create "*Done Items by Tag*")))
        (with-current-buffer output-buffer
          (let ((inhibit-read-only t))
            (erase-buffer)
            (org-mode)
            (insert (format "* Done Items This Week (by Tag)\n"))
            (insert (format "  Week: %s - %s\n\n"
                            (format-time-string "%Y-%m-%d" week-start)
                            (format-time-string "%Y-%m-%d" (time-subtract week-end (days-to-time 1)))))

            ;; Sort tags alphabetically
            (let ((sorted-tags '()))
              (maphash (lambda (k _v) (push k sorted-tags)) tag-items)
              (setq sorted-tags (sort sorted-tags #'string<))

              (if (null sorted-tags)
                  (insert "No DONE items found for this week.\n")
                (dolist (tag sorted-tags)
                  (let ((items (gethash tag tag-items)))
                    (insert (format "** %s\n" tag))
                    (dolist (item (reverse items))
                      (insert (format "   - %s\n" item)))
                    (insert "\n"))))))
          (goto-char (point-min))
          (read-only-mode 1))
        (display-buffer output-buffer))))
  (defun itsf/org-region-to-dashlist-side-buffer (beg end)
    "Convert Org headings in region to an indented dash list in a side window.
Keeps body text; only headings are rewritten.

Indentation is relative to the smallest heading level in the region, so the
topmost headings in the region start at column 0."
    (interactive "r")
    (let* ((src (buffer-substring-no-properties beg end))
           (outbuf (get-buffer-create "*org dashlist*"))
           (minlevel nil))
      ;; First pass: find minimum heading level in region
      (with-temp-buffer
        (insert src)
        (goto-char (point-min))
        (while (re-search-forward "^\\(\\*+\\)\\s-+\\(.*\\)$" nil t)
          (setq minlevel (if minlevel
                             (min minlevel (length (match-string 1)))
                           (length (match-string 1))))))
      (setq minlevel (or minlevel 1))
      ;; Second pass: produce output
      (with-current-buffer outbuf
        (let ((inhibit-read-only t))
          (erase-buffer)
          (insert src)
          (goto-char (point-min))
          (while (re-search-forward "^\\(\\*+\\)\\s-+\\(.*\\)$" nil t)
            (let* ((level (length (match-string 1)))
                   (title (match-string 2))
                   (rel-level (- level minlevel))             ; 0 for topmost in region
                   (indent (make-string (* 2 (max 0 rel-level)) ?\s)))
              (replace-match (format "%s- %s" indent title) t t))))
        (goto-char (point-min))
        (text-mode))
      (display-buffer-in-side-window
       outbuf
       '((side . right)
         (slot . 0)
         (window-width . 0.5)))))
  ;; The tree-sitter layer treats fold indicators and folding as either/or
  ;; (layers/+tools/tree-sitter/packages.el): when
  ;; `tree-sitter-fold-indicators-enable' is non-nil it only hooks
  ;; `ts-fold-indicators-mode' and never reaches its `global-ts-fold-mode' call.
  ;; But `ts-fold-indicators--enable' just renders the fringe -- it's
  ;; `ts-fold--enable' that registers ts-fold in `evil-fold-list'. Indicators
  ;; alone therefore draw fold arrows while zc/zo still fall through to
  ;; hideshow, which has no `ruby-mode' entry in Emacs 30.2 and so folds paren
  ;; sexps but not do/end. Enable the fold mode alongside the indicators.
  ;; Code buffers only. `ts-fold-range-alist' has an `org-mode' entry and
  ;; tree-sitter turns on in org too, and `ts-fold--enable' pushes itself to the
  ;; *front* of `evil-fold-list' -- so enabling it everywhere would make zc/za
  ;; in org fold tree-sitter nodes instead of outline sections, shadowing the
  ;; `(outline-mode outline-minor-mode org-mode markdown-mode)' entry. (TAB is
  ;; unaffected either way; org-cycle is org's own binding, not evil's dispatch.)
  (defun itsf/ts-fold-mode-in-code-buffers ()
    "Enable `ts-fold-mode', but only where tree-sitter folding should win."
    (when (derived-mode-p 'prog-mode)
      (ts-fold-mode 1)))
  (add-hook 'tree-sitter-after-on-hook #'itsf/ts-fold-mode-in-code-buffers)

  ;; Keep tree-sitter out of org buffers. `global-tree-sitter-mode' turns
  ;; tree-sitter on wherever `tree-sitter-major-mode-language-table' names a
  ;; grammar, and tree-sitter-langs maps `org-mode' to the org grammar. So every
  ;; org buffer got a parser, and `tree-sitter--after-change' reparsed it on
  ;; every keystroke. In a 347 KB notes file that cost 0.36s per character: 20
  ;; characters took 7.19s with tree-sitter and 0.004s without it.
  ;;
  ;; Nothing here uses that parse tree. `tree-sitter-syntax-highlight-enable' is
  ;; nil, and `itsf/ts-fold-mode-in-code-buffers' above limits ts-fold to
  ;; `prog-mode'. Dropping the org entry leaves every code buffer untouched.
  (with-eval-after-load 'tree-sitter-langs
    (when (hash-table-p tree-sitter-major-mode-language-table)
      (remhash 'org-mode tree-sitter-major-mode-language-table)))

  ;; Toggle folds with `;'. Bound in ts-fold's own minor-mode map rather than
  ;; `evil-normal-state-map', which would shadow plain major-mode bindings
  ;; everywhere -- magit, for one, puts `magit-section-toggle' on TAB in
  ;; `magit-mode-map' with no evil auxiliary override, so a global binding there
  ;; silently breaks section toggling. Scoped this way it only exists in code
  ;; buffers. The cost is `evil-repeat-find-char', whose reverse partner `,' is
  ;; already the Spacemacs major-mode leader, so f/t repeat was one-directional
  ;; anyway. z-prefixed folding (za/zc/zo/zR/zM) keeps working unchanged.
  (with-eval-after-load 'ts-fold
    (evil-define-minor-mode-key 'normal 'ts-fold-mode (kbd ";")
      #'evil-toggle-fold))

  ;; `ts-fold--foldable-node-at-pos' only walks *up* the parse tree from point
  ;; (ts-fold.el:352). In Ruby that makes a block unfoldable from most of its
  ;; own header line: for `group :development do', the ancestor chain at column
  ;; 0 is identifier -> call -> program, because the `do_block' is a *sibling*
  ;; subtree under the enclosing `call' and only starts at the `do' keyword. So
  ;; zc worked with point on `do' and nowhere else on the line. vim folds the
  ;; block on the current line, so fall back to scanning the line for one.
  ;; Advising the lookup rather than the commands fixes zc/zo/za/zC together.
  ;; Prefer a node that *starts* on the current line over whatever encloses
  ;; point. Both halves matter: without the line scan, `group :development do'
  ;; folds only from the `do' column; without the start-position filter, a
  ;; nested hash line like `nested: {' walks straight up to the enclosing hash
  ;; and folds the whole outer literal instead of the one under the cursor.
  ;; Lines that open nothing (`gem "benchmark"') fall through to ORIG and close
  ;; the innermost block containing point, which is what vim's zc does.
  (defun itsf/ts-fold--foldable-node-on-line (orig &optional pos)
    "Prefer the first foldable node starting on POS's line; else ORIG at POS."
    (let ((pos (or pos (point))))
      (or (save-excursion
            (goto-char pos)
            (let ((bol (line-beginning-position))
                  (eol (line-end-position))
                  (found nil))
              (goto-char bol)
              (while (and (not found) (< (point) eol))
                (let ((node (funcall orig (point))))
                  (when (and node (<= bol (tsc-node-start-position node) eol))
                    (setq found node)))
                (forward-char 1))
              found))
          (funcall orig pos))))
  (with-eval-after-load 'ts-fold
    (advice-add 'ts-fold--foldable-node-at-pos :around
                #'itsf/ts-fold--foldable-node-on-line)
    ;; `ts-fold-parsers-ruby' covers do/def/class/array but not brace forms, so
    ;; big config hashes stay unfoldable. `hash' is the `{...}' literal (nested
    ;; ones are just `hash' again, so they fold independently); `block' is the
    ;; brace form of a block, `each { |i| ... }'. `ts-fold-range-seq' folds
    ;; start+1..end-1, i.e. exactly between the braces.
    (let ((rules (alist-get 'ruby-mode ts-fold-range-alist)))
      (dolist (rule '((hash . ts-fold-range-seq)
                      (block . ts-fold-range-seq)))
        (unless (assq (car rule) rules)
          (push rule rules)))
      (setf (alist-get 'ruby-mode ts-fold-range-alist) rules)))

  (global-auto-revert-mode t)
  (with-eval-after-load "tramp"
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
    (add-to-list 'tramp-remote-path "/workspaces/dev-environment/bin"))
  ;; Per-directory local variable values previously approved via Customize.
  ;; Kept here as code so they're versioned alongside the rest of the config.
  (setq safe-local-variable-values
        '((js2-basic-offset . 2) (web-mode-indent-style . 2)
          (web-mode-block-padding . 2) (web-mode-script-padding . 2)
          (web-mode-style-padding . 2) (ruby-prettier-on-save . t)
          (typescript-backend . tide) (typescript-backend . lsp)
          (javascript-backend . tide) (javascript-backend . tern)
          (javascript-backend . lsp)))
  (custom-set-faces
   '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
  ;; ghostel setup lives in the Spacemacs shell layer as of upstream a10be2cb1:
  ;; the `ghostel'/`evil-ghostel' packages, `spacemacs/shell-pop-ghostel' (so
  ;; `shell-default-shell' set to 'ghostel works for SPC ' and SPC a t s g), the
  ;; repl registration, and `ghostel-shell' from `shell-default-term-shell'.
  ;; Don't re-pin ghostel in `dotspacemacs-additional-packages': the MELPA build
  ;; bundles etc/terminfo where `ghostel--terminfo-directory' expects it, and
  ;; evil-ghostel advises ghostel internals closely enough that the two have to
  ;; be upgraded together -- a pinned ghostel plus the layer's evil-ghostel is
  ;; void-function `ghostel-alt-screen-p' on every terminal buffer.
  ;; `ghostel-module-directory' is set in `dotspacemacs/user-init'.
  ;;
  ;; avoid warnings from minimum-version ghostel bumps that are actually correct
  ;; by downloading at startup before loading is checked. Real faults (module
  ;; missing, load failure) still warn.
  (if (featurep 'ghostel)
      (message "ghostel loaded before user-config; module refresh skipped")
    (when (require 'ghostel-module-install nil t)
      (let* ((dir (ghostel--module-directory))
             (ver (ghostel--read-module-sidecar-version dir)))
        (when (and ver (version< ver ghostel--minimum-module-version))
          (message "Refreshing ghostel module %s -> %s"
                   ver ghostel--minimum-module-version)
          (ghostel--ensure-module dir)))))
  (with-eval-after-load 'claude-code-ide
    (setq claude-code-ide-terminal-backend 'ghostel)
    (setq claude-code-ide-use-ide-diff nil))
  ;; Override spacemacs-layouts/non-restricted-buffer-list-helm to require
  ;; helm-buffers before the let binding, so defcustom helm-buffer-list-reorder-fn
  ;; runs (declaring it special/dynamic) before the lexical let can grab it.
  ;; Without this: helm-buffers loads lazily inside the let on first SPC b B use,
  ;; causing "Defining as dynamic an already lexical var: helm-buffer-list-reorder-fn"
  (defun spacemacs-layouts/non-restricted-buffer-list-helm ()
    (interactive)
    (require 'helm-buffers)
    (let ((helm-buffer-list-reorder-fn #'helm-buffers-reorder-buffer-list))
      (helm-mini)))
  ;;(setq org-columns-default-format "%50ITEM %TODO %CLOSED")
  (defun my/skip-non-todo-past-scheduled ()
    "Skip non-TODO entries showing as overdue (scheduled before the day being rendered)."
    (let ((scheduled (org-get-scheduled-time (point)))
          (todo (org-get-todo-state)))
      (when (and scheduled
                 (not todo)
                 (boundp 'date)
                 (< (time-to-days scheduled)
                    (calendar-absolute-from-gregorian date)))
        (org-end-of-subtree t))))

  (with-eval-after-load 'org-agenda
    (setq org-agenda-skip-function-global #'my/skip-non-todo-past-scheduled)
    (setq org-agenda-entry-types '(:deadline :scheduled :sexp))
    (setq org-agenda-show-inherited-tags t)
    (setq org-agenda-files (directory-files-recursively itsf/org-notes-directory "org$"))
    (add-to-list 'org-agenda-custom-commands
                 '("z" "Done All"
                   tags "+TODO=\"DONE\"+CLOSED>\"<-14d>\""
                   ((org-agenda-cmp-user-defined (cmp-date-property "CLOSED"))
                    (org-agenda-sorting-strategy '(user-defined-down))
                    (org-agenda-view-columns-initially t)
                    (org-agenda-overriding-columns-format "%50ITEM %TAGS %TODO %CLOSED")
                    ))
                 )
    (add-to-list 'org-agenda-custom-commands
                 `("b" ,(format "Done %s" itsf/client-agenda-tag)
                   tags ,(format "%s+TODO=\"DONE\"+CLOSED>\"<-120d>\"" itsf/client-agenda-tag)
                   ((org-agenda-cmp-user-defined (cmp-date-property "CLOSED"))
                    (org-agenda-sorting-strategy '(user-defined-down))
                    (org-agenda-view-columns-initially t)
                    (org-agenda-overriding-columns-format "%50ITEM %ALLTAGS %TODO %CLOSED")
                    ))
                 )
    (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode "n" 'itsf/agenda-jump-to-linked-notes)
    )

  (defun itsf/agenda-jump-to-linked-notes ()
    "From an org-agenda calendar entry, jump to notes that link back to it.
Searches `itsf/client-notes-file' for entries whose SOURCE_EVENT property
contains a gcal: link with the same entry-id as the agenda item."
    (interactive)
    (let* ((marker (or (org-get-at-bol 'org-hd-marker)
                       (org-get-at-bol 'org-marker)))
           (heading (when marker
                      (org-with-point-at marker
                        (org-get-heading t t t t))))
           (entry-id (when marker
                       (org-with-point-at marker
                         (org-entry-get nil org-gcal-entry-id-property)))))
      (unless heading
        (user-error "No agenda heading at point"))
      (unless entry-id
        (user-error "No entry-id found for agenda item: %s" heading))
      (let* ((notes-file (expand-file-name itsf/client-notes-file))
             (search-str (regexp-quote entry-id))
             (matches nil))
        (with-temp-buffer
          (insert-file-contents notes-file)
          (org-mode)
          (goto-char (point-min))
          (while (re-search-forward
                  (format ":SOURCE_EVENT:.*gcal:%s" search-str) nil t)
            (let ((match-end (point)))
              (when (re-search-backward "^\\*+ " nil t)
                (let ((pos (point))
                      (entry-heading (buffer-substring-no-properties
                                      (point) (line-end-position))))
                  (unless (assoc entry-heading matches)
                    (push (cons entry-heading pos) matches))))
              (goto-char match-end))))
        (cond
         ((null matches)
          (message "No linked notes found for: %s" heading))
         ((= 1 (length matches))
          (find-file notes-file)
          (goto-char (cdar matches))
          (org-show-entry)
          (org-show-children)
          (message "Found notes for: %s" heading))
         (t
          (let* ((choice (completing-read
                          (format "Notes for \"%s\": " heading)
                          (mapcar #'car matches) nil t))
                 (pos (cdr (assoc choice matches))))
            (find-file notes-file)
            (goto-char pos)
            (org-show-entry)
            (org-show-children)))))))

  (setq dotspacemacs-distinguish-gui-tab t)
                                        ;(setq enh-ruby-deep-indent-construct nil)
                                        ;(setq enh-ruby-hanging-brace-deep-indent-level 1)
                                        ;(setq ruby-use-smie nil)
  (with-eval-after-load 'ellama
    (setopt ellama-language "English") ; Set the language for Ellama
    (require 'llm-ollama) ; Require the llm-ollama library
    (setopt ellama-provider
            (make-llm-ollama
             :chat-model "ollama.ai/library/codellama" ; Specify the model
             :embedding-model "ollama.ai/library/codellama")) ; Specify the embedding model
    )
  (with-eval-after-load 'company
    ;; disable inline previews
    (delq 'company-preview-if-just-one-frontend company-frontends))

  (with-eval-after-load 'inf-ruby
    ;; check for binding.irb prompt
    (setq inf-ruby-breakpoint-pattern
          (concat inf-ruby-breakpoint-pattern "\\|\\(irb\\(.*?\\)>\\)")))

  ;; Clickable org notifications. AppleScript's `display notification' (what
  ;; alert's osx-notifier style uses) produces banners that do nothing when
  ;; clicked; terminal-notifier can run a command on click, so route org-alert
  ;; through it and have the click jump Emacs to the heading that fired.
  (defvar itsf/terminal-notifier "/opt/homebrew/bin/terminal-notifier"
    "Absolute path: the asdf shim of the same name is a dead gem stub.")

  (defvar itsf/org-alert-location nil
    "(FILE HEADING) of the entry `org-alert--dispatch' is currently notifying.")

  (defvar itsf/org-notification-layout "agenda"
    "Layout a clicked org notification opens the agenda in.")

  (defun itsf/org-agenda-goto-entry (file heading)
    "Put point on the agenda line for HEADING in FILE. Return non-nil if found.
Agenda lines carry a marker back to their entry, so match on that rather
than on the displayed text, which org decorates with times and categories."
    (let ((target (file-truename file))
          (found nil))
      (goto-char (point-min))
      (while (and (not found) (not (eobp)))
        (let* ((m (or (org-get-at-bol 'org-hd-marker) (org-get-at-bol 'org-marker)))
               (buf (and m (marker-buffer m)))
               (mfile (and buf (buffer-file-name buf))))
          (if (and mfile
                   (string= target (file-truename mfile))
                   (string= heading (org-with-point-at m
                                      (substring-no-properties
                                       (org-get-heading t t t t)))))
              (setq found t)
            (forward-line 1))))
      (when found
        (beginning-of-line)
        (recenter))
      found))

  (defun itsf/org-goto-notification (file heading)
    "Raise Emacs and show the agenda, point on the HEADING from FILE that fired.
The entry's own buffer is a poor landing spot -- most reminders come from
calendar.org, a sync dump rather than notes -- whereas the agenda line has
RET/TAB back to the entry and the usual jump-to-notes bindings."
    (let ((frame (or (seq-find #'display-graphic-p (frame-list)) (selected-frame))))
      (select-frame-set-input-focus frame)
      (when (bound-and-true-p persp-mode)
        (persp-frame-switch itsf/org-notification-layout frame))
      (let ((org-agenda-window-setup 'only-window))
        (org-agenda-list))
      (itsf/org-agenda-goto-entry file heading)))

  (defun itsf/emacs-app-bundle ()
    "Path of the running Emacs .app, or nil. Derived rather than hardcoded:
there is no /Applications/Emacs.app, and the emacs-plus Cellar path
carries a version number that moves on upgrade."
    (let ((app (directory-file-name (expand-file-name "../.." invocation-directory))))
      (and (string-suffix-p ".app" app) (file-directory-p app) app)))

  (defvar itsf/org-alert-sound "Ping"
    "Sound for the first banner of a burst. Names come from /System/Library/Sounds.")

  (defvar itsf/org-alert-sound-gap 240
    "Seconds of quiet before an entry may sound again.
org-alert re-notifies every `org-alert-interval' seconds until its cutoff,
so a gap of a few intervals keeps a repeat burst silent after its first
banner while still sounding for a genuinely new reminder -- a second
reminder later on the same meeting, or the same heading tomorrow.")

  (defvar itsf/org-alert-last-notified (make-hash-table :test 'equal)
    "Entry key -> last notification time, for `itsf/org-alert-sound-p'.")

  (defun itsf/org-alert-sound-p (key)
    "Whether KEY should sound now. Records this notification either way."
    (let* ((now (float-time))
           (last (gethash key itsf/org-alert-last-notified)))
      (maphash (lambda (k time)
                 (when (> (- now time) 86400)
                   (remhash k itsf/org-alert-last-notified)))
               itsf/org-alert-last-notified)
      (puthash key now itsf/org-alert-last-notified)
      (or (null last) (> (- now last) itsf/org-alert-sound-gap))))

  (defvar itsf/org-alert-icon (expand-file-name "emacs-logo.png" dotspacemacs-directory)
    "Logo shown on org banners, checked into this repo alongside init.el.
macOS ignores -appIcon since Big Sur, so the logo rides along as
-contentImage, which needs an image file rather than the app's icns.")

  (defun itsf/alert-terminal-notifier (info)
    "Notify via terminal-notifier, clickable when INFO came from an org entry."
    (let* ((loc itsf/org-alert-location)
           (file (car loc))
           (heading (cadr loc))
           (key (if file (concat file "\0" heading) "emacs"))
           (icon (and (file-exists-p itsf/org-alert-icon) itsf/org-alert-icon))
           (args (append
                  (list "-title"   (format "%s" (or (plist-get info :title) "Emacs"))
                        "-message" (or (plist-get info :message) "")
                        ;; no -sender: attributing the banner to another app
                        ;; makes macOS activate that app on click and drop
                        ;; -execute, which is the whole point here
                        ;; group per heading: a repeated reminder replaces its
                        ;; predecessor instead of stacking up in the centre
                        "-group"   (secure-hash 'md5 key))
                  (when icon (list "-contentImage" icon))
                  (when (and itsf/org-alert-sound (itsf/org-alert-sound-p key))
                    (list "-sound" itsf/org-alert-sound))
                  (when file
                    (list "-execute"
                          ;; `open -a' runs after emacsclient returns, so Emacs
                          ;; takes focus last. Activating from inside Emacs
                          ;; races terminal-notifier's own activation and
                          ;; loses: the agenda appears but the keyboard stays
                          ;; wherever it was.
                          (concat
                           (format "%s -e %s >/dev/null 2>&1"
                                   (shell-quote-argument
                                    (or (executable-find "emacsclient")
                                        "/opt/homebrew/bin/emacsclient"))
                                   (shell-quote-argument
                                    (format "(itsf/org-goto-notification %S %S)"
                                            file heading)))
                           (when-let ((app (itsf/emacs-app-bundle)))
                             (format "; /usr/bin/open -a %s"
                                     (shell-quote-argument app)))))))))
      (apply #'call-process itsf/terminal-notifier nil 0 nil args)))

  (require 'alert)
  (alert-define-style 'itsf/clickable
                      :title "Clickable macOS notification via terminal-notifier"
                      :notifier #'itsf/alert-terminal-notifier)

  (defun itsf/org-alert-capture-location (orig &rest args)
    "Record where ORIG is notifying from, for `itsf/alert-terminal-notifier'."
    (let ((itsf/org-alert-location
           (list (buffer-file-name (buffer-base-buffer))
               ;; unpropertized: this string gets printed into a shell command
               (substring-no-properties (org-get-heading t t t t)))))
      (apply orig args)))

  (defvar itsf/org-alert--scan-cache (make-hash-table :test 'equal)
    "Cache for `itsf/org-alert-candidate-files'.
Keys are file names. Each value is (DAY MTIME SIZE MATCH-P). A file is
re-read only when its day, modification time, or size differs.")

  (defun itsf/org-alert--file-matches-p (file re day)
    "Non-nil when FILE holds a timestamp that RE matches, for DAY.
Re-reads FILE only when the cached entry is for another day, or the file
changed on disk. `insert-file-contents-literally' skips coding detection and
the file name handlers, so `set-auto-coding' does not run editorconfig on
every agenda file. RE matches plain ASCII, so raw bytes are enough."
    (let* ((attrs (file-attributes file))
           (mtime (and attrs (file-attribute-modification-time attrs)))
           (size (and attrs (file-attribute-size attrs)))
           (hit (gethash file itsf/org-alert--scan-cache)))
      (if (and hit attrs
               (equal (nth 0 hit) day)
               (equal (nth 1 hit) mtime)
               (equal (nth 2 hit) size))
          (nth 3 hit)
        (let ((match
               (and attrs
                    (with-temp-buffer
                      (when (ignore-errors (insert-file-contents-literally file) t)
                        (goto-char (point-min))
                        (and (re-search-forward re nil t) t))))))
          (puthash file (list day mtime size match) itsf/org-alert--scan-cache)
          match))))

  (defun itsf/org-alert-candidate-files ()
    "Agenda files that hold a SCHEDULED or DEADLINE timestamp dated today.

`org-alert-match-string' compares the stored timestamp text, and
`org-map-entries' does not project repeaters forward, so an entry matches
only when its timestamp literally carries today's date. A plain regexp pass
is an exact prefilter, not an approximation: it drops no entry that
org-alert can return.

The pass covers every agenda file, but reads only the ones that changed
since the last run. A file that did not change costs one `file-attributes'
call. Without that cache the check read about 36 MB every 30 seconds, which
paused the editor twice a minute."
    (let ((re (concat "^[ \t]*\\(?:SCHEDULED\\|DEADLINE\\):.*<"
                      (format-time-string "%Y-%m-%d")))
          (day (format-time-string "%Y-%m-%d"))
          (files nil))
      (dolist (file (org-agenda-files) (nreverse files))
        (let ((buf (get-file-buffer file)))
          (if buf
              ;; Search the buffer, not the file: an open buffer can be
              ;; narrowed, and can hold a timestamp that is not saved yet.
              ;; A buffer costs no disk read, so it needs no cache.
              (with-current-buffer buf
                (save-excursion
                  (save-restriction
                    (widen)
                    (goto-char (point-min))
                    (when (re-search-forward re nil t) (push file files)))))
            (when (itsf/org-alert--file-matches-p file re day)
              (push file files)))))))

  (defun itsf/org-alert-scope-to-candidates (orig &rest args)
    "Run ORIG over `itsf/org-alert-candidate-files' rather than every agenda file.
Binds `org-agenda-files' instead of calling `org-map-entries' here, so
org-alert keeps ownership of its match string and its skip form. A day with
no timed entry leaves the list empty, and then `org-map-entries' visits
nothing at all."
    (let ((org-agenda-files (itsf/org-alert-candidate-files)))
      (apply orig args)))

  (setq alert-default-style (if (file-executable-p itsf/terminal-notifier)
                                'itsf/clickable
                              'osx-notifier))
  (with-eval-after-load 'org-alert
    (advice-add 'org-alert--dispatch :around #'itsf/org-alert-capture-location)
    (advice-add 'org-alert--map-entries :around #'itsf/org-alert-scope-to-candidates)
    (setq org-alert-interval 30
          org-alert-notify-cutoff 8
          org-alert-notify-after-event-cutoff 2
          org-alert-time-match-string "\\(?:SCHEDULED\\|DEADLINE\\):.*?<.*?\\([0-9]\\{2\\}:[0-9]\\{2\\}\\).*>"))

  (setq ob-mermaid-cli-path "~/.asdf/shims/mmdc")
  (with-eval-after-load 'org
    (add-to-list 'org-babel-load-languages '(mermaid . t)))
  (defun my/forge-filter-notifications-by-owner-url (owner)
    "Filter Forge notifications in the current buffer by OWNER substring using the 'url' slot.
OWNER can be a substring, e.g., \"fritz\" will match \"iftheshoefritz\"."
    (interactive "sOwner/org substring to filter by: ")
    (let* ((notifs (forge--ls-notifications forge-notifications-selection))
           (filtered
            (cl-remove-if-not
             (lambda (notif)
               (let ((url (ignore-errors (oref notif url))))
                 (and url
                      (string-match "/repos/\\([^/]+\\)/" url)
                      (let ((found-owner (match-string 1 url)))
                        (and found-owner
                             (string-match-p (regexp-quote owner) found-owner))))))
             notifs)))
      (let ((buf (get-buffer "*forge-notifications*")))
        (if (not buf)
            (message "No *forge-notifications* buffer found!")
          (with-current-buffer buf
            (let ((inhibit-read-only t))
              (erase-buffer)
              (magit-insert-section (notifications)
                                    (if (not filtered)
                                        (insert (format "(no notifications for this owner substring: %s)\n" owner))
                                      (progn
                                        (message "Found %d notifications for owner substring %s" (length filtered) owner)
                                        (dolist (notif filtered)
                                          (forge-insert-notification notif)))))))))))
  ;; TODO fix this later
  ;;(with-eval-after-load 'forge
  ;;  (transient-append-suffix
  ;;    'forge-list-menu "m"
  ;;    '("o" "owner/org" my/forge-filter-notifications-by-owner-url)))
  (with-eval-after-load 'magit
    (with-eval-after-load 'forge
      (defun my-forge-visit-advice (orig-fun &rest args)
        "Custom advice for forge-visit-this-topic."
        (let ((section (magit-current-section)))
          (if (and section
                   (eq (oref section type) 'pullreq))
              (code-review-forge-pr-at-point)
            (apply orig-fun args))))

      (advice-add 'forge-visit-this-topic :around #'my-forge-visit-advice)))

  (use-package mcp
    :defer t
    :after gptel
    :demand t
    :config
    (setq mcp-hub-servers
          `(
            ("fetch" . (:command "uvx" :args ("mcp-server-fetch")))
            ("git" . (:command "uvx" :args ("mcp-server-git")))
            ))
    (require 'mcp-hub)
    (mcp-hub-start-all-server)) ;; TODO why isn't this starting the servers automatically after gptel loads?

  (use-package opencode
    :after gptel
    :config
    (opencode-setup))

  (defun my/code-review-comment-edit ()
    "Edit comment at point."
    (interactive)
    (when-let* ((section (magit-current-section))
                (comment-obj (oref section value)))
      ;; The comment-obj IS the actual comment object we need
      (message "Setting code-review-comment-uncommitted to: %S" comment-obj)
      (setq code-review-comment-uncommitted comment-obj))
    (code-review-comment-edit))
  (defun my/inspect-section ()
    "Inspect the current section in detail."
    (interactive)
    (let ((section (magit-current-section)))
      (if (not section)
          (message "No section at point")
        (message "Section: %S" section)
        (message "Section type: %S" (oref section type))
        (message "Section value: %S" (oref section value)))))
  (with-eval-after-load 'code-review

    (add-hook 'code-review-mode-hook
              (lambda ()
                (define-key code-review-mode-map (kbd "C-c C-e") 'my/code-review-comment-edit)))
    )
  (defun itsf/export-for-print ()
    (interactive)
    (let ((original-themes custom-enabled-themes))
      (mapc #'disable-theme custom-enabled-themes)
      (load-theme 'leuven t)
      (htmlize-buffer)
      (mapc #'disable-theme custom-enabled-themes)
      (mapc (lambda (theme) (load-theme theme t)) original-themes)))

  (defun itsf/ghostel--unique-buffer-name (base)
    "Return \"BASE [N]\" for the lowest N with no existing buffer."
    (let ((counter 0)
          (name nil))
      (setq name (format "%s [%d]" base counter))
      (while (get-buffer name)
        (setq counter (1+ counter))
        (setq name (format "%s [%d]" base counter)))
      name))

  (defun itsf/ghostel--start (base-buffer-name directory)
    "Create a fresh ghostel terminal named after BASE-BUFFER-NAME in DIRECTORY.
`ghostel' with no prefix arg reuses the single buffer named by
`ghostel-buffer-name', so let-bind that to a numbered name (the same
trick `ghostel-project' uses) to get one buffer per invocation.
Terminal title tracking is disabled buffer-locally so ghostel does not
rename the buffer out from under the numbering."
    (require 'ghostel)
    (let* ((name (itsf/ghostel--unique-buffer-name base-buffer-name))
           (default-directory (file-name-as-directory directory))
           (ghostel-buffer-name name)
           (buffer (ghostel)))
      (with-current-buffer buffer
        (setq-local ghostel-set-title-function nil))
      buffer))

  (defun itsf/start-ghostel-numbered ()
    "Start a ghostel terminal in the project root."
    (interactive)
    (itsf/ghostel--start
     "*ghostel*"
     (or (projectile-project-root) (expand-file-name "~"))))

  (defun itsf/start-ghostel-command (command &optional buffer-prefix)
    "Start a numbered ghostel terminal in the project root, sending COMMAND.
If BUFFER-PREFIX is given, use it as the base buffer name, otherwise use the COMMAND."
    (let ((project-root (projectile-project-root)))
      (if project-root
          (with-current-buffer (itsf/ghostel--start
                                (format "*%s*" (or buffer-prefix command))
                                project-root)
            (ghostel-send-string (concat command "\n")))
        (message "Not in a Projectile project."))))

  (defun itsf/start-console-flightctl (environment)
    "Start flightctl console in a numbered ghostel buffer."
    (interactive
     (list (completing-read "Select environment: " '("dev" "staging" "production") nil t "dev")))
    (itsf/start-ghostel-command
     (format "bin/aws-console -e %s" environment)
     (format "aws-rails c: %s" environment)))

  (defun itsf/start-psql-flightctl (environment)
    "Start aws-psql in a numbered ghostel buffer."
    (interactive
     (list (completing-read "Select environment: " '("dev" "staging" "production") nil t "dev")))
    (itsf/start-ghostel-command
     (format "bin/aws-psql -e %s" environment)
     (format "aws-psql: %s" environment)))

  (defvar itsf/ghostel-target-buffer nil
    "Name of the last ghostel buffer used for sending input.")

  (defun itsf/send-region-to-ghostel (start end)
    "Send the region from START to END to a ghostel buffer as input.
      Prompts for a ghostel buffer, defaulting to the last used one."
    (interactive "r")
    (let* ((bufs (seq-filter
                  (lambda (b)
                    (with-current-buffer b
                      (derived-mode-p 'ghostel-mode)))
                  (buffer-list)))
           (buf-names (mapcar #'buffer-name bufs))
           (def (and itsf/ghostel-target-buffer
                     (member itsf/ghostel-target-buffer buf-names)
                     itsf/ghostel-target-buffer))
           (target (completing-read "Send to ghostel buffer: " buf-names nil t nil nil def))
           ;; Remove ONE trailing newline, if present
           (input (replace-regexp-in-string "\n\\'" "" (buffer-substring-no-properties start end))))
      (when (fboundp 'pulse-momentary-highlight-region)
        (pulse-momentary-highlight-region start end))
      (setq itsf/ghostel-target-buffer target)
      ;; Show the buffer if not visible
      (unless (get-buffer-window target t)
        (pop-to-buffer target))
      (with-current-buffer target
        (ghostel-send-string input)
        (ghostel-send-key "return"))))


  (spacemacs/set-leader-keys "ot" 'itsf/start-ghostel-numbered)
  (spacemacs/set-leader-keys "oc" 'itsf/start-console-flightctl)
  (spacemacs/set-leader-keys "op" 'itsf/start-psql-flightctl)
  (spacemacs/set-leader-keys "ov" 'itsf/send-region-to-ghostel)

  (use-package gptel
    :defer t
    :init
    ;; setup to make gptel bindings available before gptel is fully loaded
    ;; wrapper functions require gptel when started
    ;; keybindings will be available early and load gptel
    (defun itsf/launch-gptel-current-layout () (interactive)
           (require 'gptel) (call-interactively #'itsf/gptel-current-layout))
    (defun itsf/enable-gptel-made-tools () (interactive)
           (require 'gptel) (call-interactively #'itsf/enable-all-gptel-tools))
    (defun itsf/remove-gptel-context () (interactive)
           (require 'gptel) (call-interactively #'gptel-context-remove-all nil))
    (spacemacs/set-leader-keys
      "$gl" 'itsf/launch-gptel-current-layout
      "$gt" 'itsf/enable-gptel-made-tools
      "$gd" 'itsf/remove-context
      )
    :config
    ;; Make Copilot the active backend, not just a registered one. Without this
    ;; `gptel-backend' stays at the built-in ChatGPT/OpenAI default, which does an
    ;; auth-source lookup for api.openai.com and errors with
    ;; "No `gptel-api-key' found in the auth source" (no OpenAI creds in authinfo).
    (setq gptel-backend (gptel-make-gh-copilot "Copilot"))
    ;; TODO I tried haiku 4.5 and it wasn't great, but asking the model to tell me its version, it claimed to be sonnet 3.5. Not sure if the model has just hallucinated the Q that way or if gptel is misconfigured.
    (setq gptel-model 'gpt-4.1)
    (setq gptel-track-media t)
    (setq gptel-default-mode 'org-mode)

    (require 'gptel-integrations)

    (defun itsf/gptel-current-layout ()
      "Call gptel with current layout's name and associate buffer with a file in the llm/ subdir of `itsf/org-notes-directory'."
      (interactive)
      (let* ((layout-name (concat (persp-name (get-frame-persp)) "llm"))
             (llm-dir (expand-file-name "llm/" itsf/org-notes-directory))
             (timestamp (format-time-string "%Y%m%d_%H%M"))
             (basename (format "%s_%s.org" layout-name timestamp))
             (target-path (expand-file-name basename llm-dir)))
        (gptel layout-name nil nil t)
        (let ((buf (get-buffer layout-name)))           ; <--- Just use layout-name as the buffer name
          (when buf
            (unless (file-directory-p llm-dir)
              (make-directory llm-dir t))
            (with-current-buffer buf
              (setq-local truncate-lines nil)
              (set-visited-file-name target-path t)
              (save-buffer)
              (message "GPTel buffer is now associated with: %s" target-path))))))

    (defun itsf/enable-all-gptel-tools ()
      "Enable all tools defined in `gptel--known-tools` without changing the structure of `gptel-tools`."
      (interactive)
      (setq gptel-tools
            (cl-union gptel-tools
                      (mapcar #'cdr (apply #'append (mapcar #'cdr gptel--known-tools))) ; Flatten tool definitions
                      :test #'eq)))
    )

  ;; Shared org-gcal core (creds, settings, SCHEDULED hook, oauth2 workaround)
  ;; lives in the repo at ~/.spacemacs.d/emacs-org-gcal-core.el so the interactive
  ;; Emacs and the background fetch child use one source of truth.
  (defvar itsf/org-gcal-core-file
    (expand-file-name "emacs-org-gcal-core.el" dotspacemacs-directory)
    "Absolute path to the shared org-gcal core. Resolved here (where
`dotspacemacs-directory' is bound) and interpolated into the async child form,
since the child Emacs has no Spacemacs loaded.")
  (require 'async)
  (load itsf/org-gcal-core-file)

  (defun itsf/org-gcal-fetch-silent ()
    "One-way fetch (Google → Org), silenced.
Like `org-gcal-fetch' (itself just `(org-gcal-sync t)') but also passes
SILENT to suppress the message/redisplay flood. SKIP-EXPORT is t, so every
API call is a read-only GET — nothing is written back to Google."
    (interactive)
    (org-gcal-sync t t))

  (defun itsf/org-gcal-archive-old-events ()
    "Archive past org-gcal events out of the fetch files.
Runs the archive step that `org-gcal-auto-archive' used to do on every
fetch, so it can be invoked separately instead of on the fetch hot path."
    (interactive)
    (dolist (i org-gcal-fetch-file-alist)
      (with-current-buffer (find-file-noselect (cdr i))
        (org-gcal--archive-old-event))))

  (defun itsf/org-gcal-fetch-background ()
    "Run a one-way fetch in a child Emacs (via async.el); revert calendar.org on completion.
The child decrypts oauth2-auto.plist via the same gpg-agent and writes calendar.org;
the parent reverts the buffer if it's open and unmodified."
    (interactive)
    (async-start
     `(lambda ()
        ,(async-inject-variables "\\`load-path\\'")
        ;; Absolute path interpolated from the parent: the child has no
        ;; `dotspacemacs-directory', so it can't resolve the location itself.
        (load ,itsf/org-gcal-core-file)
        ;; Force a FULL sync every run instead of incremental. The incremental
        ;; sync token (org-gcal--sync-tokens, persisted in ~/.emacs.d/persist/)
        ;; is a single-shot cursor that gets corrupted when shared between this
        ;; child and the long-lived interactive Emacs: they diverge, deltas get
        ;; dropped, and the fetch silently no-ops (ok · Δ+0 bytes) while new
        ;; events never land. Clearing the token makes each fetch a complete
        ;; download that can't drift. entry-id values are deterministic from the
        ;; Google event id, so gcal: links in notes files keep resolving across
        ;; rewrites.
        ;;
        ;; But a full (tokenless) list only ever returns *live* events; Google
        ;; reports cancellations/deletions solely as syncToken deltas, which we
        ;; just threw away. So the full sync alone can add and update but never
        ;; prune — events cancelled in Google (e.g. a meeting rescheduled by
        ;; replacing its series) linger in calendar.org indefinitely. Wiping the
        ;; fetch window first (itsf/org-gcal-prune-fetch-window) turns the full
        ;; sync into a true replace within its window, so cancelled events
        ;; actually disappear. The prune is window-scoped, so out-of-window
        ;; past/future entries survive. Order matters: prune, then sync.
        (setq org-gcal--sync-tokens nil)
        (let* ((calfile (expand-file-name (cdar org-gcal-fetch-file-alist)))
               (size-before (if (file-exists-p calfile)
                                (file-attribute-size (file-attributes calfile)) 0))
               ;; Snapshot taken *before* the prune, so a run that doesn't finish
               ;; can be rolled back wholesale. The prune deletes the entire fetch
               ;; window up front and relies on the sync to put it back, and
               ;; org-gcal saves calendar.org while syncing — so a sync that errors
               ;; or times out leaves the gutted (or half-refilled) window on disk,
               ;; silently dropping events that are still live in Google. A later
               ;; run doesn't reliably heal that: a full list only re-adds what
               ;; Google returns, so an event being mutated in Google around the
               ;; fetch can stay missing indefinitely. Restoring the snapshot makes
               ;; prune+sync atomic: either the replace ran to completion, or
               ;; calendar.org is exactly as it was.
               (backup (expand-file-name "org-gcal-calendar-backup.org"
                                         temporary-file-directory))
               (start (current-time)) (done nil) (result "ok"))
          (when (file-exists-p calfile) (copy-file calfile backup t t))
          (itsf/org-gcal-prune-fetch-window)
          (deferred:try
           (org-gcal-sync t t)
           :catch   (lambda (e) (setq result (format "error: %S" e)))
           :finally (lambda () (setq done t)))
          (with-timeout (180 (setq result "timeout") (setq done t))
            (while (not done) (accept-process-output nil 0.2)))
          ;; Drain: org-gcal-sync's main deferred resolves after dispatching
          ;; the post-fetch sync-buffer mapc, but its sub-deferreds (per-entry
          ;; updates that fire the SCHEDULED hook) keep running. Pump the
          ;; event loop a few more seconds so they finish in the child instead
          ;; of being abandoned on exit.
          (let ((drain-end (+ (float-time) 5.0)))
            (while (< (float-time) drain-end)
              (accept-process-output nil 0.2)))
          (save-some-buffers t)
          ;; Roll back after the save, not instead of it: org-gcal may already
          ;; have written a partial window to disk during the sync, so the only
          ;; reliable undo is to put the pre-prune file back.
          (unless (string= result "ok")
            (when (file-exists-p backup)
              (copy-file backup calfile t t)
              (setq result (concat result " · rolled back"))))
          (let ((size-after (if (file-exists-p calfile)
                                (file-attribute-size (file-attributes calfile)) 0)))
            (format "%s in %.2fs · calendar.org %d→%d (Δ%+d bytes)"
                    result
                    (float-time (time-subtract (current-time) start))
                    size-before size-after (- size-after size-before)))))
     (lambda (result)
       ;; expand-file-name: get-file-buffer doesn't expand ~, so without
       ;; this the lookup misses the buffer (whose buffer-file-name is the
       ;; full absolute path) and we never revert. Path comes from the
       ;; (externalised) org-gcal-fetch-file-alist, same file the fetch writes.
       (let ((buf (get-file-buffer
                   (expand-file-name (cdar org-gcal-fetch-file-alist)))))
         (when buf
           (with-current-buffer buf
             ;; Force-revert even if modified: calendar.org is machine-owned
             ;; (single-writer rule), and an in-process foreground fetch can
             ;; leave the buffer modified-but-unsaved via late SCHEDULED hook
             ;; edits, which would otherwise mask the child's disk writes.
             (revert-buffer t t t))))
       ;; Refresh every live org-agenda buffer (visible or not) so a
       ;; hidden agenda is fresh next time you switch to it. Deferred to an
       ;; idle timer so the redo (still blocking under Emacs's single
       ;; thread) waits for a pause rather than firing while you're typing.
       (run-with-idle-timer
        0.2 nil
        (lambda ()
          (dolist (buf (buffer-list))
            (when (buffer-live-p buf)
              (with-current-buffer buf
                (when (derived-mode-p 'org-agenda-mode)
                  (org-agenda-redo)))))))
       (message "org-gcal background fetch: %s" result))))

  ;; Schedule the background fetch every 20 minutes. Cancel any existing timer
  ;; first so reloads (SPC f e R) don't stack duplicate timers.
  (defvar itsf/org-gcal-fetch-timer nil
    "Timer object for the repeating background org-gcal fetch.")
  (when itsf/org-gcal-fetch-timer (cancel-timer itsf/org-gcal-fetch-timer))
  (setq itsf/org-gcal-fetch-timer
        (run-with-timer 0 (* 20 60) #'itsf/org-gcal-fetch-background))

  (org-link-set-parameters "gcal"
                           :follow (lambda (entry-id)
                                     (let ((location (org-generic-id-find
                                                      org-gcal-entry-id-property entry-id)))
                                       (if location
                                           (progn
                                             (find-file (car location))
                                             (goto-char (cdr location))
                                             (org-show-entry)
                                             (org-show-children))
                                         (user-error "Calendar entry not found for entry-id: %s" entry-id))))
                           :store nil)

  (defun itsf/capture-gcal-source-event-link ()
    "Build a [[gcal:ENTRY-ID][Heading]] link from the agenda item being captured."
    (let* ((ann (plist-get org-capture-plist :annotation))
           (orig-buf (org-capture-get :original-buffer))
           (marker (when orig-buf
                     (with-current-buffer orig-buf
                       (or (org-get-at-bol 'org-hd-marker)
                           (org-get-at-bol 'org-marker)))))
           (entry-id (when marker
                       (org-with-point-at marker
                         (org-entry-get nil org-gcal-entry-id-property))))
           (heading (when (and ann (string-match "\\[\\[.*?\\]\\[\\(.*?\\)\\]\\]" ann))
                      (match-string 1 ann))))
      (unless entry-id
        (user-error "No entry-id found on agenda item — capture must be invoked from an org-gcal calendar entry"))
      (format "[[gcal:%s][%s]]" entry-id heading)))



  ;; Per-frame fallback: bind C-M-m as major-mode emacs leader on TTY frames
  (defun itsf/tty-major-mode-leader-fallback (frame)
    "Bind C-M-m as the major-mode emacs leader on TTY frames."
    (with-selected-frame frame
      (unless (display-graphic-p frame)
        (when (boundp 'spacemacs-major-mode-emacs-leader-key-map)
          (global-set-key (kbd "C-M-m") spacemacs-major-mode-emacs-leader-key-map)))))
  (add-hook 'after-make-frame-functions #'itsf/tty-major-mode-leader-fallback)
  (itsf/tty-major-mode-leader-fallback (selected-frame))

  ;; Suppress icon fonts on TTY frames to prevent tofu rendering
  (defun itsf/disable-icons-on-tty (frame)
    "Suppress icon fonts on TTY frames so they don't render as tofu."
    (with-selected-frame frame
      (unless (display-graphic-p frame)
        (setq-local all-the-icons-scale-factor 0.0)
        (when (bound-and-true-p nerd-icons-mode)
          (nerd-icons-mode -1)))))
  (add-hook 'after-make-frame-functions #'itsf/disable-icons-on-tty)

  ;; Kill spawned subprocesses on Emacs shutdown
  (defun itsf/kill-spawned-processes ()
    (when (fboundp 'mcp-hub-stop-all-server) (mcp-hub-stop-all-server))
    (dolist (p (process-list))
      (when (and (process-live-p p)
                 (string-match-p "mcp-server\\|uvx" (or (process-name p) "")))
        (delete-process p))))
  (add-hook 'kill-emacs-hook #'itsf/kill-spawned-processes)

  ;; Idle reaper for dead MCP process objects (hygiene for long daemon uptime)
  (run-with-idle-timer
   1800 t
   (lambda ()
     (dolist (p (process-list))
       (when (and (string-match-p "mcp-server" (or (process-name p) ""))
                  (not (process-live-p p)))
         (delete-process p)))))

  ;; --- Rails routes.rb imenu -------------------------------------------------
  ;; ruby-mode's `ruby-imenu-create-index' only knows class/module/def/alias, so
  ;; a routes file (pure DSL) produces a completely empty `SPC j i' index. Index
  ;; the routing DSL instead, keeping each line's own leading whitespace in the
  ;; label so the nesting is visible in the helm list (same trick rspec-mode
  ;; uses for describe/context/it).
  (defvar itsf/rails-routes-imenu-re
    (concat "^\\([ \t]*\\)"
            "\\(namespace\\|scope\\|resources\\|resource\\|concern\\|constraints\\|"
            "get\\|post\\|put\\|patch\\|delete\\|match\\|root\\|mount\\|draw\\)"
            "\\_>[ \t]*\\(.*?\\)[ \t]*$")
    "Matcher for Rails routing DSL calls: indent, keyword, remainder of line.")

  (defun itsf/rails-routes-imenu-index ()
    "Build a flat imenu index of Rails routes, indented to show nesting."
    (let ((index nil))
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward itsf/rails-routes-imenu-re nil t)
          (let* ((indent (replace-regexp-in-string "\t" "  " (match-string 1)))
                 (kw     (match-string-no-properties 2))
                 (rest   (match-string-no-properties 3))
                 (pos    (match-beginning 2))
                 (arg (if (string-match
                           "\\`[ \t]*\\(?::\\([A-Za-z0-9_]+\\)\\|\"\\([^\"]+\\)\\|'\\([^']+\\)\\)" rest)
                          (or (match-string 1 rest) (match-string 2 rest) (match-string 3 rest))
                        (let ((s (string-trim
                                  (replace-regexp-in-string "\\_<do\\_>.*\\'" "" rest))))
                          (if (> (length s) 40) (concat (substring s 0 40) "...") s)))))
            (push (cons (string-trim-right (format "%s%s %s" indent kw (or arg "")))
                        pos)
                  index))))
      (nreverse index)))

  (defun itsf/rails-routes-file-p ()
    "Non-nil if the current buffer visits a Rails routes file."
    (and buffer-file-name
         (string-match-p "/config/\\(routes\\.rb\\'\\|routes/.*\\.rb\\'\\)" buffer-file-name)))

  (defun itsf/rails-routes-setup-imenu ()
    "Give Rails routes files a DSL-aware, indentation-preserving imenu index.
Runs from `ruby-mode-hook'; also callable interactively to apply it to a
buffer that was opened before this config was loaded."
    (interactive)
    (when (itsf/rails-routes-file-p)
      ;; ruby-mode sets `imenu-create-index-function' to `ruby-imenu-create-index'
      ;; (and ruby-ts-mode to `treesit-simple-imenu'), both of which ignore
      ;; `imenu-generic-expression' -- so override the function itself.
      (setq-local imenu-create-index-function #'itsf/rails-routes-imenu-index)
      ;; Deeply nested entries would otherwise be chopped at 60 chars.
      (setq-local imenu-max-item-length nil)
      (setq-local imenu--index-alist nil)
      ;; helm caches its own candidate list keyed on `buffer-modified-tick', so
      ;; an index built before this hook ran (an empty one) would be served
      ;; forever in an unmodified buffer. Invalidate it too.
      (when (boundp 'helm-cached-imenu-tick)
        (setq-local helm-cached-imenu-tick nil)
        (setq-local helm-cached-imenu-candidates nil))))

  (add-hook 'ruby-mode-hook    #'itsf/rails-routes-setup-imenu)
  (add-hook 'ruby-ts-mode-hook #'itsf/rails-routes-setup-imenu)

  ;; Ensure org notifications start under both daemon and non-daemon launch
  (defun itsf/start-notifications ()
    (when (require 'org-alert nil t) (org-alert-enable))
    (when (fboundp 'org-notify-start) (org-notify-start)))
  (if (daemonp)
      (add-hook 'emacs-startup-hook #'itsf/start-notifications)
    (itsf/start-notifications))
  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
Intentionally empty: Customize output is redirected to a gitignored
custom.el via `custom-file' (set in `dotspacemacs/user-init'), so Spacemacs
no longer rewrites auto-generated settings back into this versioned file."
  )
