;; This is where your customizations should live
(package-initialize)
(projectile-global-mode)
(evil-mode 1)
(setq evil-default-cursor t)
(desktop-save-mode 0)
(global-auto-revert-mode t)  ; auto reload all buffers
(setq auto-save-default nil)

(load-file "~/.emacs.d/util.el")

(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c t") 'ansi-term)
(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))

;; Repositories
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;; Packages
(require 'package)
(require 'use-package)

(use-package evil
  :ensure t
  :init (timeit
	 "EVIL"

	 (defun new-tab ()
	   "Open file in new tab."
	   (interactive)
	   (ido-find-file-other-frame))

	 (defun delete-tab ()
	   "Delete current tab."
	   (interactive)
	   (delete-frame))

	 (defun next-tab ()
	   "Switch to next tab."
	   (interactive)
	   (other-frame 1))

	 (defun previous-tab ()
	   "Switch to previous tab."
	   (interactive)
	   (other-frame -1))

	 (use-package evil-nerd-commenter
	   :ensure t)

	 (evil-mode t)
	 ;; (define-key evil-normal-state-map (kbd ",t") 'new-tab)
	 (define-key evil-normal-state-map (kbd "C-w t") 'new-tab)
	 (define-key evil-normal-state-map (kbd "C-w x") 'delete-tab)
	 (define-key evil-normal-state-map (kbd "lL") 'next-tab)
	 (define-key evil-normal-state-map (kbd "gT") 'previous-tab)
	 (define-key evil-normal-state-map (kbd ",gg") 'vc-git-grep)
	 (define-key evil-normal-state-map (kbd ",G") 'rgrep)
	 (define-key evil-normal-state-map (kbd ",m") 'menu-bar-mode)
	 (define-key evil-visual-state-map (kbd ",c") 'evilnc-comment-or-uncomment-lines)
	 ))


(require 'magit)
;;  ;; magit stuff!!
;(magit-file-header ((t (:foreground "violet"))))
;(magit-hunk-header ((t (:foreground "blue"))))
;; (magit-header ((t (:foreground "cyan"))))
;; (magit-tag-label ((t (:background "blue" :foreground "orange"))))
;; (magit-diff-add ((t (:foreground "MediumSlateBlue"))))
;; (magit-diff-del ((t (:foreground "maroon"))))

;; change magit diff colors

(eval-after-load 'magit
  '(set-face-attribute 'magit-item-highlight () :bold t :background ()))
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")

     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))
(defun disable-magit-highlight-in-buffer () 
  
  (face-remap-add-relative 'magit-item-highlight '()))


(add-hook 'magit-status-mode-hook 'disable-magit-highlight-in-buffer)


 (defface magit-item-highlight
   (if magit-diff-use-overlays
       '((((background light)) :background "grey")
         (((background dark)) :background "gray16"))
     '((t :bold t)))
   "Face for highlighting the current item.
 Also see option `magit-diff-use-overlays'."
   :group 'magit-faces
   :set-after '(magit-diff-use-overlays))

(define-key global-map "\C-cf" 'projectile-find-file)

(setq find-file-wildcards t)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/elpa/tabbar/")
(require 'tabbar)
(global-set-key (kbd "C-h") 'tabbar-backward)
(global-set-key (kbd "C-l") 'tabbar-forward)

(global-set-key (kbd "C-j") 'tabbar-backward-group)
(global-set-key (kbd "C-k") 'tabbar-forward-group)

;; `tabbar-backward-group'     (C-c <C-up>)
;; `tabbar-forward-group'      (C-c <C-down>)


(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)


(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq default-tab-width 4)
;(setq tab-width 4)
;(setq c-basic-indent 4)


;; keep visual mode active when indenting
(define-key evil-visual-state-map (kbd "<") (lambda ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore)))
(define-key evil-visual-state-map (kbd ">") (lambda ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore)))

;; this mode-hook is taken straight from the comments in autopair.el
(add-hook 'python-mode-hook
		   (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t))
	)


(defun write-room ()
  "Make a frame without any bling."
  (interactive)
  ;; to restore:
  ;; (setq mode-line-format (default-value 'mode-line-format))
  (let ((frame (make-frame '((minibuffer . nil)
			     (vertical-scroll-bars . nil)
			     (left-fringe . 0); no fringe
			     (right-fringe . 0)
			     (background-mode . dark)
			     (background-color . "black")
			     (foreground-color . "green")
			     (cursor-color . "green")
			     (border-width . 0)
			     (border-color . "black"); should be unnecessary
			     (internal-border-width . 64); whitespace!
			     (cursor-type . box)
			     (menu-bar-lines . 0)
			     (tool-bar-lines . 0)
			     (mode-line-format . nil) ; dream on... has no effect
			     (fullscreen . fullboth)  ; this should work
			     (unsplittable . t)))))
    (select-frame frame)
    (find-file "~/NOTES")
    (setq mode-line-format nil); is buffer local unfortunately
    ;; maximize window if fullscreen above had no effect
    (when (fboundp 'w32-send-sys-command)
      (w32-send-sys-command 61488 frame))))

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1)               ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t)

(autoload 'markdown-mode "markdown-mode"
		     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))

;; ------- desktop config
;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; remove desktop after it's been read
;; (add-hook 'desktop-after-read-hook
;; 	  '(lambda ()
;; 	     ;; desktop-remove clears desktop-dirname
;; 	     (setq desktop-dirname-tmp desktop-dirname)
;; 	     (desktop-remove)
;; 	     (setq desktop-dirname desktop-dirname-tmp)))

(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))

(setq magit-diff-use-overlays nil)
;; use session-restore to restore the desktop manually
(defun session-restore ()
  "Restore a saved emacs session."
  (interactive)
  (if (saved-session)
      (desktop-read)
    (message "No desktop found.")))

;; use session-save to save the desktop manually
(defun session-save ()
  "Save an emacs session."
  (interactive)
  (if (saved-session)
      (if (y-or-n-p "Overwrite existing desktop? ")
	  (desktop-save-in-desktop-dir)
	(message "Session not saved."))
  (desktop-save-in-desktop-dir)))

;; ask user whether to restore desktop at start-up
(add-hook 'after-init-hook
	  '(lambda ()
	     (if (saved-session)
		 (if (y-or-n-p "Restore desktop? ")
		     (session-restore)))))
;; --------- /close-desktop-config

;; env PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Place downloaded elisp files in this directory. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)
