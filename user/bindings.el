(global-set-key "\C-x\C-b" 'buffer-menu)
;; (global-set-key (kbd "C-c h") 'windmove-left)
;; (global-set-key (kbd "C-c j") 'windmove-down)
;; (global-set-key (kbd "C-c k") 'windmove-up)
;; (global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c t") 'ansi-term)
(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))

(provide 'bindings)
