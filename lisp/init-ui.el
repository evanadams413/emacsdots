(setq inhibit-startup-message t)

(scroll-bar-mode -1)    ; 关闭文件滑动控件
(tool-bar-mode -1)      ; 关闭工具栏
(tooltip-mode -1)       ; 关闭工具提示
(icomplete-mode 1)

(menu-bar-mode -1)      ; 关闭菜单栏

(set-face-attribute 'default nil :font "Victor Mono" :height 200)

;; === dashboard ===
(require 'all-the-icons)
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")     ;; 设置标题
;; (setq dashboard-startup-banner 'official)     ;; 设置标语
(setq dashboard-startup-banner (expand-file-name "lisp/communist.txt" user-emacs-directory))
;; VALUE 可以是:
;; - nil 表示不显示横幅
;; - 'official emacs 官方徽标的 'official
;; - 'logo 显示其他 emacs 徽标
;; - 1、2 或 3 显示文字横幅之一
;; - "path/to/your/image.gif"、"path/to/your/image.png
;;   "path/to/your/text.txt"
;;   "path/to/your/image.xbm"。
;;   这将显示您喜欢的任何 gif/图像/文本/xbm 文件
;; - ("path/to/your/image.png". "path/to/your/text.txt") 的 icons

;; 内容默认不居中。要居中，请设置
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)

;; dashboard 小部件 . 数量
;; recents -> 文件      bookmarks -> 书签       projects -> 项目
;; agenda -> 组织       registers -> 注册小部件
(setq dashboard-items '(
                        (projects . 5)
                        (recents . 15)
                        ))
;; icons
(setq dashboard-icon-type 'all-the-icons) 
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-init-info t)    ;; 显示有关加载的包和初始化时间的信息
(setq dashboard-footer-messages '("Dashboard is pretty cool!"))
(setq dashboard-projects-switch-function 'projectile-persp-switch-project) ;; projectile

;; 在横幅下方显示导航器
;; (setq dashboard-set-navigator t)
;; Format: "(icon title help action face prefix suffix)"

(provide 'init-ui)
