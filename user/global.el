
(evil-mode 1)
(setq evil-default-cursor t)
(desktop-save-mode 0)
(global-auto-revert-mode t)  ; auto reload all buffers
(setq auto-save-default nil)
(projectile-global-mode)
(setq make-backup-files nil)

;; Set the number to the number of columns to use.
(setq-default fill-column 79)

;; Add Autofill mode to mode hooks.
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Show line number in the mode line.
(line-number-mode 1)

;; Show column number in the mode line.
(column-number-mode 1)

(remove-hook 'text-mode-hook 'turn-on-flyspell)

;; (setq indent-tabs-mode t)
;; (setq-default indent-tabs-mode t)
;; ;; (global-set-key (kbd "TAB") 'self-insert-command)
;; (setq default-tab-width 4)
;; (setq tab-width 4)
;; (setq c-basic-indent 4)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

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

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(provide 'global)
