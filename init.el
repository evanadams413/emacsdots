(add-to-list 'load-path "~/.config/emacs/lisp/")

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
        ("http" . "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))

;; Package Management
;; -----------------------------------------------------------------
(require 'init-func)
(require 'init-options)
(require 'init-ui)
(require 'init-package)
(require 'init-evil)
(require 'init-keybindings)
(require 'init-edit)
