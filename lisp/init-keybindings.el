(when *is-mac*
(global-set-key (kbd "s-a") 'mark-whole-buffer) ; 对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ; 对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ; 对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ; 对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ; 对应Windows上面的Ctrol-x 剪切
)

(general-define-key
  :states '(normal visual)
  :prefix "SPC"
  "hc" 'hope/clearn-highlight
  "hH" 'hope/highlight-dwim
)
(general-define-key :states '(normal visual) "RET" 'er/expand-region)

;; file
(general-define-key
  :states '(normal visual)
  :prefix "SPC"
  "ff" 'find-file
  "fF" 'find-file-other-window
  "f/" 'find-file-other-window
  "fD" '+delete-current-file
  "fC" '+copy-current-file
  "fy" '+copy-current-filename
  "fR" '+rename-current-file
  "fr" 'recentf-open-files)

(global-set-key (kbd "<S-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<S-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<S-down>") 'shrink-window)
(global-set-key (kbd "<S-up>") 'enlarge-window)

(provide 'init-keybindings)
