(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager
(require 'buffer-move)   ;; Buffer-move for better window management
(require 'evil-setup) ;; The Evil mode
(require 'frame-fns) ;; frame-cmds dependency
(require 'frame-cmds) ;; Frame and Window commands

;; (set-language-environment "UTF-8")
(setq-default buffer-file-coding-system 'utf-8-unix)

(set-terminal-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

(use-package company
  :defer 2
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))

(setq default-frame-alist
      '((top . 220) (left . 400)
        (width . 220) (height . 60)))

(setq initial-frame-alist '((top . 220) (left . 400)))

(global-set-key (kbd "C-<left>") 'move-frame-left)
(global-set-key (kbd "C-<up>") 'move-frame-up)
(global-set-key (kbd "C-<right>") 'move-frame-right)
(global-set-key (kbd "C-<down>") 'move-frame-down)

(global-set-key (kbd "C-S-<right>") 'enlarge-frame-horizontally)
(global-set-key (kbd "C-S-<down>") 'enlarge-frame)
(global-set-key (kbd "C-S-<left>") 'shrink-frame-horizontally)
(global-set-key (kbd "C-S-<up>") 'shrink-frame)

;; override org commands
(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-S-<right>") #'enlarge-frame-horizontally)
  (define-key org-mode-map (kbd "C-S-<down>") #'enlarge-frame)
  (define-key org-mode-map (kbd "C-S-<left>") #'shrink-frame-horizontally)
  (define-key org-mode-map (kbd "C-S-<up>") #'shrink-frame))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; (use-package all-the-icons-dired
;;   :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq visible-bell 1)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Oakmura Emacs")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/minecraft-dolphin.gif") ;; custom image
  ;;(setq dashboard-startup-banner "~/.config/emacs/images/bear-resize.gif") ;; custom image
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 35
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(set-face-attribute 'default nil
  :font "JetBrains Mono"
  ;;:font "HackNerdFont-Regular"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu"
  ;;:font "HackNerdFont-Regular"
  :height 110
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  ;;:font "HackNerdFont-Regular"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))
;; (add-to-list 'default-frame-alist '(font . "HackNerdFont-Regular"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(setq text-scale-mode-step 1.1)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
;; (load-theme 'magonyx t)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Sets the default theme to load!!! 
  ;; (load-theme 'doom-one t)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package gruvbox-theme
   :config
   (load-theme 'gruvbox-dark-soft t)
)

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))

(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)

(use-package projectile
  :config
  (projectile-mode 1))

(global-set-key [escape] 'keyboard-escape-quit)

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " - " ))

;;(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(global-hl-line-mode t) ;; highlight current line
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(setq scroll-step 1)         ;; Automatic scroll step near margin
(setq scroll-margin 10)
(setq scroll-conservatively 9999) ;; Disable screen jump near margin

(require 'org-tempo)

(defun transparent(alpha-level no-focus-alpha-level)
"Let's you make the window transparent"
(interactive "nAlpha level (0-100): \nnNo focus alpha level (0-100): ")
(set-frame-parameter (selected-frame) 'alpha (list alpha-level no-focus-alpha-level))
(add-to-list 'default-frame-alist `(alpha ,alpha-level)))

(when window-system
(set-frame-parameter (selected-frame) 'alpha (list 92 92))
(add-to-list 'default-frame-alist `(alpha ,92)))

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer oakm/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (oakm/leader-keys
    ;; "SPC" '(counsel-M-x :wk "Counsel M-x")
    ;; "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    ;; "u" '(universal-argument :wk "Universal argument")
    "." '(find-file :wk "Find file")
    "TAB TAB" '(comment-line :wk "Comment lines"))

  (oakm/leader-keys
    ;; "SPC" '(counsel-M-x :wk "Counsel M-x")
    ;; "f l" '(counsel-locate :wk "Locate a file")
    ;; "f r" '(counsel-recentf :wk "Find recent files")
    "f" '(:ignore t :wk "Files/Frames")    
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
    "f d" '((lambda () (interactive) (dired "C:/Users/jaero/OneDrive/바탕 화면")) :wk "Open user-desktop-directory in dired")
    "f e" '((lambda () (interactive) (dired "~/.config/emacs/")) :wk "Open user-emacs-directory in dired")
    "f t" '(transparent :wk "Set transparency"))

  (oakm/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

  (oakm/leader-keys
    "e" '(:ignore t :wk "Evaluate/Eshell")    
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e s" '(eshell :wk "Eshell"))

  (oakm/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h t" '(load-theme :wk "Load theme")
    "h r r" '((lambda () (interactive)
		(load-file "~/.config/emacs/init.el")
		(ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    )

  (oakm/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t v" '(visual-line-mode :wk "Toggle truncated lines")
    "t t" '(toggle-frame-fullscreen :wk "Toggle frame fullscreen")
    "t n" '(neotree-toggle :wk "Toggle neotree"))

  (oakm/leader-keys
    "w" '(:ignore t :wk "Windows/Words")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
    ;; Words
    "w U" '(upcase-word :wk "Upcase word")
    "w u" '(downcase-word :wk "Downcase word")
    "w =" '(count-words :wk "Count words/lines for buffer"))
  )

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      ;; eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      ;; eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t)

(use-package pdf-tools
  :defer t
  :init
  (setenv "PATH" (concat "C:/msys64/mingw64/bin" ";" (getenv "PATH")))
  (pdf-tools-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))

  :custom
  (pdf-info-epdfinfo-program "C:/msys64/mingw64/bin/epdfinfo.exe"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)
                                                         (blink-cursor-mode -1)
                                                         (doom-modeline-mode -1)))

;; if want to disable 
;; (setq make-backup-files nil)
;; (setq create-lockfiles nil)

;; if want to enable, but do not want to see them
(setq backup-directory-alist '(("." . "~/.config/emacs/backup"))) ;; temporary backup files. might have to use absolute path
;;   backup-by-copying t    ; Don't delink hardlinks
;;   version-control t      ; Use version numbers on backups
;;   delete-old-versions t  ; Automatically delete excess backups
;;   kept-new-versions 20   ; how many of the newest versions to keep
;;   kept-old-versions 5    ; and how many of the old
;;   )
;; (setq lock-file-name-transforms `((".*" "~/.config/emacs/backup" t))) ;; lockfiles for simultaneous access to a file
