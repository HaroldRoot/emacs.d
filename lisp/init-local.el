;;; init-local.el --- Add my own customization -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(set-language-environment "Chinese-GB")
(prefer-coding-system 'utf-8)

(require 'hello-world)
(require 'cheer-me-up)

;; 在关闭 emacs 前询问是否确认关闭，防止误触
(setq confirm-kill-emacs #'yes-or-no-p)
;; 自动补全括号
(electric-pair-mode t)
;; 编程模式下，光标在括号上时高亮另一个括号
(add-hook 'prog-mode-hook #'show-paren-mode)
;; 在 Mode Line 上显示列号
(column-number-mode t)
;; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(global-auto-revert-mode t)
;; 选中文本后输入文本会替换文本
(delete-selection-mode t)
;; 关闭启动 Emacs 时的欢迎界面
(setq inhibit-startup-message t)
;; 关闭文件自动备份
(setq make-backup-files nil)
;; 编程模式下，可以折叠代码块
(add-hook 'prog-mode-hook #'hs-minor-mode)
;; 在 Window 显示行号
(global-display-line-numbers-mode 1)
;; 关闭 Tool bar
(tool-bar-mode -1)
;; 图形界面时关闭滚动条
(when (display-graphic-p) (toggle-scroll-bar -1))

;; 打开 Buffer 历史记录保存
(savehist-mode 1)
;; 显示相对行号
(setq display-line-numbers-type 'relative)
;; 设定启动图形界面时的初始 Frame 宽度（字符数）
(add-to-list 'default-frame-alist '(width . 90))
;; 设定启动图形界面时的初始 Frame 高度（字符数）
(add-to-list 'default-frame-alist '(height . 40))

(global-set-key (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-m") 'move-beginning-of-line)
(global-set-key (kbd "C-c '") 'comment-or-uncomment-region)

(provide 'init-local)

;;; init-local.el ends here
