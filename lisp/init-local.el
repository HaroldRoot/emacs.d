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

(eval-when-compile
  (require 'use-package))

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . 'swiper)
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-@" . 'counsel-mark-ring)
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

(use-package amx
  :ensure t
  :init (amx-mode))

(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))

(use-package mwim
  :ensure t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-auto-save-history nil))

(use-package smart-mode-line
  :ensure t
  :init (sml/setup))

(use-package good-scroll
  :ensure t
  :if window-system
  :init (good-scroll-mode))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t)
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence)))

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))

(use-package yasnippet
  :ensure t
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  ;; add company-yasnippet to company-backends
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  ;; unbind <TAB> completion
  (define-key yas-minor-mode-map [(tab)]    nil)
  (define-key yas-minor-mode-map (kbd "TAB")  nil)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  :bind
  (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(global-set-key (kbd "M-/") 'hippie-expand)

(provide 'init-local)

;;; init-local.el ends here
