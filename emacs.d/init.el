;; Emacs configuration file
;;
;;

;; ---  Tweaks {{

;; Always load newest byte code
(setq load-prefer-newer t)

;; Reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; --- }}


;; MEPLA package-archive
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; EVIL mode
(require 'evil)
(evil-mode 1)

;; Keys bindings
;; See http://whattheemacsd.com/ for details
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)

;; No splash sceen please
(setq inhibit-startup-message t)

;; Initial window settings
(setq initial-frame-alist
      '((width . 92)
	(height . 54)))

;; --- Theme and Appearance {{
; For somethin' more lightweight
(require 'twilight-bright-theme)
(load-theme 'twilight-bright t)

;(require 'doom-themes)
;(setq doom-themes-enable-bold t
;      doom-themes-enable-italic t)
;(load-theme 'doom-one t)
;(doom-themes-visual-bell-config)
;(doom-themes-org-config)
;(add-hook 'find-file-hook 'doom-buffer-mode)

(set-face-attribute 'default nil :family "Fira Mono")
(setq-default line-spacing 3)
(set-face-attribute 'default nil :height 120)
(setq-default cursor-type 'bar)

;; --- }}

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Write backup files to own dir
(setq backup-directory-alist
      `(("." . ,(expand-file-name
		 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Join lines into one line
(global-set-key (kbd "M-j")
		(lambda ()
		  (interactive)
		  (join-line -1)))

;; =========================================
;; Various stuff atomatically added by Emacs
;; =========================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8" default)))
 '(package-selected-packages
   (quote
    (evil twilight-bright-theme doom-themes zenburn-theme atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
