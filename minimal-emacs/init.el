;; package
(package-initialize)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)

;; ivy
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
(ivy-mode 1)
(setq ivy-wrap t
      ivy-re-builders-alist '((t . ivy--regex-fuzzy))
      ivy-use-selectable-prompt t)

;; counsel
(unless (package-installed-p 'counsel)
  (package-install 'counsel))
(global-set-key (kbd "M-x") 'counsel-M-x)

;; smex
(unless (package-installed-p 'smex)
  (package-install 'smex))

;; undo-tree
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(global-undo-tree-mode)
(setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

;; magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; org-mode
(unless (package-installed-p 'org)
  (package-install 'org))
(unless (package-installed-p 'toc-org)
  (package-install 'toc-org))
(add-hook 'org-mode-hook 'toc-org-enable)
(unless (package-installed-p 'org-bullets)
  (package-install 'org-bullets))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(require 'org-tempo)

;; which-key
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(which-key-mode)

;; eshell
(unless (package-installed-p 'eshell)
  (package-install 'eshell))
(unless (package-installed-p 'eshell-syntax-highlighting)
  (package-install 'eshell-syntax-highlighting))
(eshell-syntax-highlighting-global-mode)

;; tldr
(unless (package-installed-p 'tldr)
  (package-install 'tldr))

;; beacon
(unless (package-installed-p 'beacon)
  (package-install 'beacon))
(beacon-mode 1)
(setq beacon-blink-when-point-moves-vertically 1
      beacon-blink-when-point-moves-horizontally nil)

;; buffer-move
(unless (package-installed-p 'buffer-move)
  (package-install 'buffer-move))

;; general
(unless (package-installed-p 'general)
  (package-install 'general))

(defconst oakm-leader "C-z")
(general-create-definer oakm-leader-def
  :keymaps 'override
  :prefix oakm-leader)

(oakm-leader-def
 "SPC" '(counsel-M-x :wk "Counsel M-x")
 "." '(find-file :wk "Find file")
 "TAB TAB" '(comment-line :wk "Comment lines")
)

(oakm-leader-def
  "b" '(:ignore t :wk "Bookmarks/Buffers")
  "b b" '(switch-to-buffer :wk "Switch to buffer")
  "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
  "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
  "b d" '(bookmark-delete :wk "Delete bookmark")
  "b i" '(ibuffer :wk "Ibuffer")
  "b k" '(kill-current-buffer :wk "Kill current buffer")
  "b K" '(kill-some-buffers :wk "Kill multiple buffers")
  "b l" '(list-bookmarks :wk "List bookmarks")
  "b m" '(bookmark-set :wk "Set bookmark")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")
  "b R" '(rename-buffer :wk "Rename buffer")
  "b s" '(basic-save-buffer :wk "Save buffer")
  "b S" '(save-some-buffers :wk "Save multiple buffers")
  "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file")
)

(oakm-leader-def
  "d" '(:ignore t :wk "Dired")
  "d d" '(dired :wk "Open dired")
  "d j" '(dired-jump :wk "Dired jump to current")
)

(oakm-leader-def
  "e" '(:ignore t :wk "Eshell/Evaluate")    
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e d" '(eval-defun :wk "Evaluate defun containing or after point")
  "e e" '(eval-expression :wk "Evaluate and elisp expression")
  "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
  "e r" '(eval-region :wk "Evaluate elisp in region")
  "e s" '(eshell :which-key "Eshell")
)

(oakm-leader-def
  "f" '(:ignore t :wk "Files")    
;;  "f c" '((lambda () (interactive)
;;            (find-file "~/.config/emacs/config.org")) 
;;          :wk "Open emacs config.org")
  "f e" '((lambda () (interactive)
            (dired "~/.config/emacs/")) 
          :wk "Open user-emacs-directory in dired")
  "f d" '(find-grep-dired :wk "Search for string in files in DIR")
  "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
  "f i" '((lambda () (interactive)
            (find-file "~/.config/emacs/init.el")) 
          :wk "Open emacs init.el")
  "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
  "f l" '(counsel-locate :wk "Locate a file")
  "f r" '(counsel-recentf :wk "Find recent files")
)

(oakm-leader-def
  "g" '(:ignore t :wk "Git")    
  "g /" '(magit-displatch :wk "Magit dispatch")
  "g ." '(magit-file-displatch :wk "Magit file dispatch")
  "g b" '(magit-branch-checkout :wk "Switch branch")
  "g c" '(:ignore t :wk "Create") 
  "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
  "g c c" '(magit-commit-create :wk "Create commit")
  "g c f" '(magit-commit-fixup :wk "Create fixup commit")
  "g C" '(magit-clone :wk "Clone repo")
  "g f" '(:ignore t :wk "Find") 
  "g f c" '(magit-show-commit :wk "Show commit")
  "g f f" '(magit-find-file :wk "Magit find file")
  "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
  "g F" '(magit-fetch :wk "Git fetch")
  "g g" '(magit-status :wk "Magit status")
  "g i" '(magit-init :wk "Initialize git repo")
  "g l" '(magit-log-buffer-file :wk "Magit buffer log")
  "g r" '(vc-revert :wk "Git revert file")
  "g s" '(magit-stage-file :wk "Git stage file")
  "g t" '(git-timemachine :wk "Git time machine")
  "g u" '(magit-stage-file :wk "Git unstage file")
)

(oakm-leader-def
  "h" '(:ignore t :wk "Help")
  "h a" '(counsel-apropos :wk "Apropos")
  "h b" '(describe-bindings :wk "Describe bindings")
  "h c" '(describe-char :wk "Describe character under cursor")
  "h d" '(:ignore t :wk "Emacs documentation")
  "h d a" '(about-emacs :wk "About Emacs")
  "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
  "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
  "h d m" '(info-emacs-manual :wk "The Emacs manual")
  "h d n" '(view-emacs-news :wk "View Emacs news")
  "h d o" '(describe-distribution :wk "How to obtain Emacs")
  "h d p" '(view-emacs-problems :wk "View Emacs problems")
  "h d t" '(view-emacs-todo :wk "View Emacs todo")
  "h d w" '(describe-no-warranty :wk "Describe no warranty")
  "h e" '(view-echo-area-messages :wk "View echo area messages")
  "h f" '(describe-function :wk "Describe function")
  "h F" '(describe-face :wk "Describe face")
  "h g" '(describe-gnu-project :wk "Describe GNU Project")
  "h i" '(info :wk "Info")
  "h I" '(describe-input-method :wk "Describe input method")
  "h k" '(describe-key :wk "Describe key")
  "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
  "h L" '(describe-language-environment :wk "Describe language environment")
  "h m" '(describe-mode :wk "Describe mode")
  "h r" '(:ignore t :wk "Reload")
  "h r r" '((lambda () (interactive)
              (load-file "~/.config/emacs/init.el"))
            :wk "Reload emacs config")
  "h t" '(load-theme :wk "Load theme")
  "h v" '(describe-variable :wk "Describe variable")
  "h w" '(where-is :wk "Prints keybinding for command if set")
  "h x" '(describe-command :wk "Display full documentation for command")
)

(oakm-leader-def
  "m" '(:ignore t :wk "Org")
  "m a" '(org-agenda :wk "Org agenda")
  "m e" '(org-export-dispatch :wk "Org export dispatch")
  "m i" '(org-toggle-item :wk "Org toggle item")
  "m t" '(org-todo :wk "Org todo")
  "m B" '(org-babel-tangle :wk "Org babel tangle")
  "m T" '(org-todo-list :wk "Org todo list")
)

(oakm-leader-def
  "m b" '(:ignore t :wk "Tables")
  "m b -" '(org-table-insert-hline :wk "Insert hline in table")
)

(oakm-leader-def
  "m d" '(:ignore t :wk "Date/deadline")
  "m d t" '(org-time-stamp :wk "Org time stamp")
)

(oakm-leader-def
  "o" '(:ignore t :wk "Open")
  "o f" '(make-frame :wk "Open buffer in new frame")
  "o F" '(select-frame-by-name :wk "Select frame by name")
)

(oakm-leader-def
  "s" '(:ignore t :wk "Search")
  "s d" '(dictionary-search :wk "Search dictionary")
  "s m" '(man :wk "Man pages")
  "s t" '(tldr :wk "Lookup TLDR docs for a command")
  "s w" '(woman :wk "Similar to man but doesn't require man")
)

(oakm-leader-def
  "t" '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t t" '(visual-line-mode :wk "Toggle truncated lines")
  "t h" '(hl-line-mode :wk "Toggle line highlight")
  "t m" '(minimap-mode :wk "Toggle minimap-mode")
)

(oakm-leader-def
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w d" '(delete-window :wk "Delete window")
    "w n" '(split-window-horizontally :wk "Split window horizontally")
    "w v" '(split-window-horizontally :wk "Split window horizontally")
    "w s" '(split-window-vertically :wk "Split window veritcally")
    ;; Window motions
    "w <left>" '(windmove-left :wk "Window left")
    "w <down>" '(windmove-down :wk "Window down")
    "w <up>" '(windmove-up :wk "Window up")
    "w <right>" '(windmove-right :wk "Window right")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
)

;; initial position
(setq default-frame-alist
      '((top . 0) (left . 800)
        (width . 180) (height . 70)))
(setq initial-frame-alist '((top . 0) (left . 700)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(good-scroll smooth-scroll pixel-scroll beacon minimap general eshell org-bullets toc-org eshell-syntax-highlighting which-key benchmark-init dired-preview peep-dired imenu-list yasnippet rainbow-delimiters magit smex undo-tree counsel ivy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

;; UTF-8 as default encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; add this especially on Windows, else python output problem
(set-terminal-coding-system 'utf-8)

;; fonts
(set-face-attribute 'default nil
  :font "JetBrains Mono Medium"
  :height 80
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu"
  :height 80
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono Medium"
  :height 80
  :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; region colors
(set-face-attribute 'region nil :background "#666")

;; to correct fonts on emacsclient
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))
(setq-default line-spacing 0.12)

;; zooming in/out
(setq text-scale-mode-step 1.1)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; weird paren matching fix
(defun show-paren--locate-near-paren-ad ()
  "Locate an unescaped paren \"near\" point to show.
If one is found, return the cons (DIR . OUTSIDE), where DIR is 1
for an open paren, -1 for a close paren, and OUTSIDE is the buffer
position of the outside of the paren.  Otherwise return nil."
  (let* ((before (show-paren--categorize-paren (point))))
    (when (or
       (eq (car before) 1)
       (eq (car before) -1))
      before)))
(advice-add 'show-paren--locate-near-paren :override #'show-paren--locate-near-paren-ad)

;; sane defaults
(delete-selection-mode 1) ;; You can select text and delete it by typing.
(setq visible-bell 1) ;; disable beep
(global-set-key [escape] 'keyboard-escape-quit) ;; minibuffer escape with one ESC
(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil) ;; use space instead of tab
(electric-indent-mode -1)
(electric-pair-mode 1) ;; disable <> auto-pairing for org-tempo snippet
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                      (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-display-line-numbers-mode 1)
(global-hl-line-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq org-edit-src-content-indentation 0)
(setq scroll-step 1) ;; automatic scroll step near margin
(setq scroll-margin 10)
(setq scroll-conservatively 9999) ;; disable screen jump near margin

;; global auto revert
;; keep buffer in sync with disk
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; backups
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; todo
;; 1. fix backups
;; 2. fix tabs
