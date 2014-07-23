(require 'package)
(require 'use-package)

;; Repositories
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)


(setq package-archives '(("josh" . "http://josh.github.com/elpa/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("elpa" . "http://tromey.com/elpa/")
                          ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar packages '(
                   ;auto-complete
                   bind-key
                   cider
                   cl-lib
                   clojure-mode
                   clojure-test-mode
                   concurrent
                   ctable
                   dash
                   deferred
                   desktop
                   diminish
                   ;elisp-slime-nav
                   elscreen
                   epc
                   epl
                   evil
                   evil-nerd-commenter
                   find-file-in-project
                   git-commit-mode
                   ;git-rebase-mode
                   ;goto-chg
                   ;goto-last-change
                   highlight-indentation
                   idle-highlight-mode
                   ido-ubiquitous
                   jedi
                   magit
                   markdown-mode
                   mustache-mode
                   paredit
                   ;pastie
                   pkg-info
                   projectile
                   python-mode
                   rainbow-delimiters
                   s
                   smex
                   starter-kit
                   starter-kit-bindings
                   starter-kit-lisp
                   ;tabbar
                   tabulated-list
                   undo-tree
                   use-package
                   ;virtualenvwrapper
                   web-mode
                   xclip
                   )
  "Libraries that should be installed by default.")

(dolist (package packages)
  (when (not (package-installed-p package))
    (package-install package)))

(provide 'elpa)
