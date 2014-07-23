;; This is where your customizations should live
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/user")
(add-to-list 'load-path "~/.emacs.d/vendor")
(load "~/.emacs.d/vendor/clojure")

(require 'elpa)
(require 'web-mode)
(require 'util)
(require 'bindings)
(require 'pkg_conf)
(require 'functions)
(require 'recentf)
(require 'global)

(setq magit-diff-use-overlays nil)

;; ask user whether to restore desktop at start-up
(add-hook 'after-init-hook
	  '(lambda ()
	     (if (saved-session)
		 (if (y-or-n-p "Restore desktop? ")
		     (session-restore)))))

(provide 'user)
