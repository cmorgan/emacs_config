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
	 ;(define-key evil-normal-state-map (kbd "lL") 'next-tab)
	 (define-key evil-normal-state-map (kbd "gT") 'previous-tab)
	 (define-key evil-normal-state-map (kbd ",gg") 'vc-git-grep)
	 (define-key evil-normal-state-map (kbd ",G") 'rgrep)
	 (define-key evil-normal-state-map (kbd ",m") 'menu-bar-mode)
	 (define-key evil-visual-state-map (kbd ",c") 'evilnc-comment-or-uncomment-lines)
	 ))


(use-package paredit
  :ensure t
  :init (progn
	  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
	  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
	  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
	  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
	  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
	  (add-hook 'haskell-mode-hook          #'enable-paredit-mode)
	  (add-hook 'inferior-lisp-mode-hook    #'enable-paredit-mode)
	  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
	  (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
	  (add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
	  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)))


(use-package magit
  :ensure t
  :config (progn
	    (define-key evil-normal-state-map (kbd ",gb") 'magit-blame-mode)
	    (global-set-key (kbd "C-x G") 'magit-status)
        ))


(use-package projectile
  :ensure t
  :init (timeit
	 "PROJECTILE"
	  (projectile-global-mode)
	  (define-key evil-normal-state-map "\C-p" 'projectile-find-file)))


(use-package ido
  :ensure t
  :init (timeit
	 "IDO"
	 (ido-mode t)
	 (ido-everywhere t)
	 (setq ido-enable-flex-matching t)
	 (setq ido-file-extensions-order '(".py" ".js" ".emacs" t))
	 ))


(use-package tool-bar
  :init (progn
	  (tool-bar-mode 0)))


(use-package hl-line
  :init (progn
	  (global-hl-line-mode)))


(use-package scroll-bar
  :init (progn
	  (scroll-bar-mode 0)))


(use-package menu-bar
  :init (progn
	  (menu-bar-mode 0)))


(use-package paren
  :init (progn
	  (show-paren-mode)))


(use-package xclip
  :ensure t
  :init (timeit
	 "XCLIP"
	 (xclip-mode t)))


(use-package jedi
  :ensure t
  :commands jedi:setup
  :config (timeit
	   "JEDI"
	   (setq jedi:complete-on-dot t)
	   (setq jedi:tooltip-method nil)))


(use-package help-mode
  :init (progn
	  (add-hook 'help-mode-hook
		    (lambda ()
		      (evil-motion-state 0)))))


(use-package virtualenvwrapper
  :ensure t
  :defer t
  :init (progn

	  (defun venv-get-proj-dir ()
	    "While in a venv, return the project directory or nil."
	    (let ((fn (concat (getenv "VIRTUAL_ENV") ".project")))
	      (if (file-exists-p fn)
		  (chomp (read-file-in-string fn)))))

	  (defun venv-cdproject ()
	    "Change directory to the current project directory, if set."
	    (interactive)
	    (let ((dir (venv-get-proj-dir)))
	      (if dir
		  (cd dir))))

	  (defun venv-workon-and-cdproject (venv)
	    (interactive "i")
	    (venv-workon venv)
	    (venv-cdproject)
	    (dired default-directory))

	  (define-key evil-normal-state-map ",w" 'venv-workon-and-cdproject))

  :config (timeit
	   "VENV"
	   (venv-initialize-interactive-shells)
	   (venv-initialize-eshell)))


(use-package js
  :init (progn
	  (add-hook 'js-mode-hook
		    (lambda ()
					(setq indent-tabs-mode nil
                ;; evil-shift-width 2
                ;; tab-width 2
                js-indent-level 2)
		      (modify-syntax-entry ?\_ "w")))))



(use-package sql
  :init (progn
	  (add-hook 'sql-mode-hook
		    (lambda ()
		      (modify-syntax-entry ?\_ "w")))))

(use-package whitespace
  :ensure t
  :init (timeit
	 "WHITESPACE"
	 (hook-into-modes 'whitespace-mode '(python-mode-hook))
	 ;; Highlight portion of lines >79
	 (setq whitespace-line-column 79)
	 (setq whitespace-style '(face lines-tail))))

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :config (progn
	    (setq indent-tabs-mode nil)
	    (setq evil-shift-width 2)
	    (setq tab-width 2)))


(use-package cider
  :commands cider-jack-in)


(use-package org
  :init (progn
	    (global-set-key (kbd "C-c o a") 'org-agenda)
	    (global-set-key (kbd "C-c o c") 'org-capture)
	    (global-set-key (kbd "C-c o l") 'org-store-link)
		(setq org-log-done t)
		)
  )

(add-to-list 'load-path "~/.emacs.d/elpa/tabbar/")
(use-package tabbar
  :init
  (progn
    (tabbar-mode 1)
	(global-set-key (kbd "C-c h") 'tabbar-backward)
	(global-set-key (kbd "C-c l") 'tabbar-forward)

	(global-set-key (kbd "C-c j") 'tabbar-backward-group)
	(global-set-key (kbd "C-c k") 'tabbar-forward-group)
	;; `tabbar-backward-group'     (C-c <C-up>)
	;; `tabbar-forward-group'      (C-c <C-down>)
	))


(use-package electric
  :init (timeit
	 "ELECTRIC"
	 ;; Ignoring electric indentation
	 (defun electric-indent-ignore-python (char)
	   "Ignore electric indentation for 'python-mode' after CHAR."
	   (if (equal major-mode 'python-mode)
	       `no-indent'
	     nil))
	 (electric-indent-mode t)
	 (add-hook 'electric-indent-functions
		   'electric-indent-ignore-python)))


;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))


(provide 'pkg_conf)
