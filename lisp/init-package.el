;; ===================================================
;; ============== Use-Package Configure ==============
;; ===================================================

(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;;(setq package-enable-at-startup nil)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.config/emacs/elpa/straight.el")
(require 'straight)


;; ===================================================
;; ============= init-better-defaults.el =============
;; ===================================================

(use-package command-log-mode)
(use-package vertico
  :ensure t
  :config (vertico-mode t))
(use-package orderless
  :config (setq completion-styles '(orderless)))
(use-package marginalia
  :config (marginalia-mode t))
;;跨文件批量搜索替换
(use-package consult
  :bind ("C-c C-s" . consult-grep)
  ("C-s" . consult-line))
(use-package embark
  :config (setq prefix-help-command 'embark-prefix-help-command)
  :bind (:map minibuffer-mode-map
   ("C-o" . embark-export)))
(use-package embark-consult)
(use-package wgrep
  :bind (:map grep-mode-map
   ("C-c C-q" . wgrep-change-to-wgrep-mode))
  :config (setq wgrep-auto-save-buffer t))
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)
(use-package benchmark-init
             :init (benchmark-init/activate)
             :hook (after-init . benchmark-init/deactivate))


;; ===================================================
;; =================== init-ui.el ====================
;; ===================================================

(use-package all-the-icons
  :config
  (setq inhibit-compacting-font-caches t)
  (setq neo-theme 'icons))
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(use-package circadian
  :ensure t
  :config
  (setq circadian-themes '(("8:00" . doom-one-light)
                           ("19:30" . doom-dracula)))
  (circadian-setup))
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;; (use-package awesome-tab
;;   :load-path "~/.config/emacs/elpa/awesome-tab/"
;;   :config
;;   (awesome-tab-mode t))
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-close-button " ")
  ;; (setq centaur-tabs-modified-marker "*")
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))


;; ===================================================
;; ================== init-evil.el ===================
;; ===================================================

(use-package general
  :config
  (general-evil-setup))
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1))
(use-package undo-tree      ;; undo & redo
  :diminish
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree))
(use-package evil-anzu      ;; 显示*匹配单词数量
  :ensure t
  :after evil
  :init
  (global-anzu-mode t))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode 1))
(use-package evil-nerd-commenter
  :init
  (define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd "gc") 'evilnc-comment-or-uncomment-lines))
;; (use-package evil-snipe
;;   :ensure t
;;   :diminish
;;   :init
;;   (evil-snipe-mode +1)
;;   (evil-snipe-override-mode +1))
(use-package evil-matchit
  :ensure
  :init
  (global-evil-matchit-mode 1))


;; ===================================================
;; ================== init-edit.el ===================
;; ===================================================

(use-package iedit
  :ensure t
  :init
  (setq iedit-toggle-key-default nil)
  :config
  (define-key iedit-mode-keymap (kbd "M-h") 'iedit-restrict-function)
  (define-key iedit-mode-keymap (kbd "M-i") 'iedit-restrict-current-line))
(use-package evil-multiedit
  :ensure t
  :commands (evil-multiedit-default-keybinds)
  :init
  (evil-multiedit-default-keybinds))
(use-package expand-region
  :config
  (defadvice er/prepare-for-more-expansions-internal
      (around helm-ag/prepare-for-more-expansions-internal activate)
    ad-do-it
    (let ((new-msg (concat (car ad-return-value)
			   ", / to search in project, "
			   "e iedit mode in functions, "
			   "f to search in files, "
			   "b to search in opened buffers"))
	  (new-bindings (cdr ad-return-value)))
      (cl-pushnew
       '("/" (lambda ()
	       (interactive)
	       (call-interactively
		'hope/search-project-for-symbol-at-point)))
       new-bindings)
      (cl-pushnew
       '("e" (lambda ()
	       (interactive)
	       (call-interactively
		'evil-multiedit-match-all)))
       new-bindings)
      (cl-pushnew
       '("f" (lambda ()
	       (interactive)
	       (call-interactively
		'find-file)))
       new-bindings)
      (cl-pushnew
       '("b" (lambda ()
	       (interactive)
	       (call-interactively
		'consult-line)))
       new-bindings)
      (setq ad-return-value (cons new-msg new-bindings)))))


;; ===================================================
;; ================= init-window.el ==================
;; ===================================================

(use-package es-windows
  :ensure t)


;; ===================================================
;; ================ init-project.el ==================
;; ===================================================

(use-package neotree)
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))
(setq projectile-switch-project-action 'neotree-projectile-action)
(use-package persp-projectile)


;; ===================================================
;; ================== init-lsp.el ====================
;; ===================================================

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
         (emmet-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package which-key
    :config
    (which-key-mode))
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))
(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  )
(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))
;; (use-package company
;;   :diminish
;;   :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
;;   :init (add-hook 'after-init-hook 'global-company-mode)
;;   :config
;;   (setq company-minimum-prefix-length 1
;;         company-show-quick-access t))
(use-package corfu
    :init
    (setq corfu-cycle t)
    (setq corfu-auto t)

    (setq corfu-quit-at-boundary t)
    (setq corfu-quit-no-match t)
    (setq corfu-preview-current nil)
    (setq corfu-min-width 80)
    (setq corfu-max-width 100)
    (setq corfu-auto-delay 0.2)
    (setq corfu-auto-prefix 1)
    (setq corfu-on-exact-match nil)
    (global-corfu-mode)
    (corfu-popupinfo-mode)

    :hook (prog-mode . nasy/setup-corfu)
    :config
    ;; (defun corfu-enable-in-minibuffer ()
    ;;   "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    ;;   (when (where-is-internal #'completion-at-point (list (current-local-map)))
    ;;     ;; (setq-local corfu-auto nil) Enable/disable auto completion
    ;;     (corfu-mode 1)))
    ;; (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

    (defun corfu-move-to-minibuffer ()
      (interactive)
      (let ((completion-extra-properties corfu--extra)
            completion-cycle-threshold completion-cycling)
        (toggle-chinese-search)
        (apply #'consult-completion-in-region completion-in-region--data)))
    (define-key corfu-map "\M-m" #'corfu-move-to-minibuffer)

    (define-key corfu-map (kbd "C-j") 'corfu-next)
    (define-key corfu-map (kbd "C-k") 'corfu-previous)
    (setq corfu-popupinfo-delay 0.4)
    (setq corfu-popupinfo-max-width 120)
    (setq corfu-popupinfo-max-height 40)
    (define-key corfu-map (kbd "s-d") 'corfu-popupinfo-toggle)
    (define-key corfu-map (kbd "s-p") #'corfu-popupinfo-scroll-down) ;; corfu-next
    (define-key corfu-map (kbd "s-n") #'corfu-popupinfo-scroll-up) ;; corfu-previous
    )


  ;; Use dabbrev with Corfu!
  (use-package dabbrev
    ;; Swap M-/ and C-M-/
    :bind (("M-/" . dabbrev-completion)
           ("C-M-/" . dabbrev-expand)))

  ;; A few more useful configurations..
  (use-package emacs
    :init
    ;; TAB cycle if there are only few candidates
    (setq completion-cycle-threshold 3)

    ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
    ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
    ;; (setq read-extended-command-predicate
    ;;       #'command-completion-default-include-p)

    ;; Enable indentation+completion using the TAB key.
    ;; `completion-at-point' is often bound to M-TAB.
    (setq tab-always-indent 'complete))

  ;; Add extensions
  (use-package cape
    ;; Bind dedicated completion commands
    :bind (("C-c p" . nil)
           ("C-c p p" . completion-at-point) ;; capf
           ("C-c p t" . complete-tag)        ;; etags
           ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
           ("C-c p f" . cape-file)
           ("C-c p k" . cape-keyword)
           ("C-c p s" . cape-symbol)
           ("C-c p a" . cape-abbrev)
           ("C-c p i" . cape-ispell)
           ("C-c p l" . cape-line)
           ("C-c p w" . cape-dict)
           ("C-c p \\" . cape-tex)
           ("C-c p _" . cape-tex)
           ("C-c p ^" . cape-tex)
           ("C-c p &" . cape-sgml)
           ("C-c p r" . cape-rfc1345))
    :init
    (setq cape-dabbrev-min-length 3)
    ;; Add `completion-at-point-functions', used by `completion-at-point'.
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-tex)
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (setq cape-dabbrev-check-other-buffers nil)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    (defun my/eglot-capf ()
      (setq-local completion-at-point-functions
                  (list (cape-super-capf
                         #'eglot-completion-at-point
                         (cape-company-to-capf #'company-yasnippet)))))

    (add-hook 'eglot-managed-mode-hook #'my/eglot-capf))

(provide 'init-package)
