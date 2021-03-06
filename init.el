(require 'package)
(package-initialize)
(package-refresh-contents)
;; Add .emacs.d to load-path
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)
(setq package-user-dir (concat dotfiles-dir "elpa"))

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Install packages for clean .emacs.d (no /elpa dir)
(unless (package-installed-p 'cider)
  (package-install 'cider))

(unless (package-installed-p 'exec-path-from-shell)
  (package-install 'exec-path-from-shell))

(unless (package-installed-p 'solarized-theme)
  (package-install 'solarized-theme))

(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))

(unless (package-installed-p 'paredit)
  (package-install 'paredit))

(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))

(unless (package-installed-p 'ag)
  (package-install 'ag))

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(unless (package-installed-p 'js2-mode)
  (package-install 'js2-mode))

(unless (package-installed-p 'magit)
  (package-install 'magit))

;;(unless (package-installed-p 'centered-cursor-mode)
;;  (package-install 'centered-cursor-mode))

(unless (package-installed-p 'helm)
  (package-install 'helm))

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(unless (package-installed-p 'helm-projectile)
  (package-install 'helm-projectile))

;; END

(require 'exec-path-from-shell)
(require 'multiple-cursors)
(require 'paredit)
;;(and
;; (require 'centered-cursor-mode)
;; (global-centered-cursor-mode +1))

;; Inherit $PATH from shell (for lein etc.)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(load-theme 'solarized-dark t)
(setq x-underline-at-descent-line t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))

;; Key settings
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'emc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; HELM config
(helm-mode 1)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(helm-autoresize-mode t)
;; HELM config

;; Projectile config
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "M-p") 'helm-projectile-find-file)
;; END Projectile config

(require 'undo-tree)
(global-undo-tree-mode 1)

(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo) ; 【Ctrl+z】
(global-set-key (kbd "C-S-z") 'redo) ; 【Ctrl+Shift+z】;  Mac style
;; END - Key settings

(show-paren-mode 1)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(ac-config-default)

;; HOOKS
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'before-save-hook
;;           (lambda ()
;;             (untabify (point-min) (point-max))))
;; END hooks

;; Detect JS files and enable js2-mode and Tern
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'load-path "/Users/dan/git/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
