;; This is where your customizations should live
(package-initialize)
(projectile-global-mode)
(evil-mode 1)
(setq evil-default-cursor t)
(desktop-save-mode 0)
(global-auto-revert-mode t)  ; auto reload all buffers

;; ------- desktop config
;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; remove desktop after it's been read
(add-hook 'desktop-after-read-hook
	  '(lambda ()
	     ;; desktop-remove clears desktop-dirname
	     (setq desktop-dirname-tmp desktop-dirname)
	     (desktop-remove)
	     (setq desktop-dirname desktop-dirname-tmp)))

(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))

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

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it

;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 20) (height . 20)))


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
;; Uncomment this to increase font size
;; (set-face-attribute 'default nil :height 140)
(load-theme 'tomorrow-night-bright t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))



