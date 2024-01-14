;; 设置 visible bell
(setq visible-bell t)

(setq make-backup-files nil)

;; 分配 custom 文件
(setq custom-file (expand-file-name "~/.config/emacs/lisp/custom.el"))
(load custom-file 'no-error 'no-message)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(setq gc-cons-threshold most-positive-fixnum)
(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(unless *is-windows*
    (set-selection-coding-system 'utf-8))

(provide 'init-options)
