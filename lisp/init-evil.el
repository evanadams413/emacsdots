(general-evil-setup)
;; * Global Keybindings
;; all keywords arguments are still supported
;; these are just wrappers around `general-def' that set a default :states
;; like spaceemacs
(general-define-key
  :states '(normal visual)
  :keymaps 'override
  :prefix "SPC"
  "!" 'shell-command
  "SPC" 'execute-extended-command
  "'" 'vertico-repeat
  "+" 'text-scale-increase
  "-" 'text-scale-decrease
  "u" 'universal-argument
  "e" 'neotree-toggle)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; normal
(general-nmap
  ;; Cursor move
  "H" 'evil-beginning-of-line
  "L" 'evil-end-of-line
  "J" 'hope/next-three-line
  "K" 'hope/previous-three-line
  ;; Windows
  "s"   'nil
  "ss"  'split-window-right
  "sv"  'split-window-below
  "so"  'delete-other-windows
  "sc"  'delete-window
  "s="  'balance-windows-area
  "sw"  'esw/select-window
  "sS"  'esw/swap-two-windows
  "sh"  'buf-move-left
  "sj"  'buf-move-right
  "sk"  'buf-move-down
  "sl"  'buf-move-up
  "C-j" 'windmove-down
  "C-k" 'windmove-up
  "C-h" 'windmove-left
  "C-l" 'windmove-right
  ;; Buffer
  "b"  'nil
  "bp" 'previous-buffer
  "bn" 'next-buffer
  "bk" 'kill-current-buffer
  "bi" 'ibuffer
  "bc" 'kill-buffer
  "bo" 'kill-other-buffers 
  ;; Tabs
  ;; "tk" 'awesome-tab-backward-tab
  ;; "tj" 'awesome-tab-forward-tab
  "tk" 'centaur-tabs-backward
  "tj" 'centaur-tabs-forward
  ;; Other
  ";" 'evil-ex
  ":" 'evil-repeat-find-char
  "<escape>" 'keyboard-escape-quit
  "U" 'evil-redo
  )

;; visual
(general-vmap
  "H" 'move-beginning-of-line
  "L" 'move-end-of-line
  "J" 'evil-collection-unimpaired-move-text-down
  "K" 'evil-collection-unimpaired-move-text-up)

(general-imap "j"
   (general-key-dispatch 'self-insert-command
   ;; :timeout 0.25
   "k" 'evil-normal-state
   "j" 'newline))

(provide 'init-evil)
