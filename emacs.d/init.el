;; Emacs configuration file
;;

;; ---  Tweaks {{

;; Always load newest byte code
(setq load-prefer-newer t)

;; Reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; --- }}

;; MEPLA package-archive and packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Set PATH variable
(exec-path-from-shell-copy-env "PATH")

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPack
  '(better-defaults
    exec-path-from-shell
    evil
    elpy
    twilight-bright-theme
    doom-themes
    all-the-icons
    neotree))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPack)


;; EVIL mode
;(require 'evil)
;(evil-mode 1)


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

;; For somethin' more lightweight
(require 'twilight-bright-theme)
(load-theme 'twilight-bright t)

(set-face-attribute 'default nil :family "Fira Code")
(setq-default line-spacing 3)
(set-face-attribute 'default nil :height 120)
(setq-default cursor-type 'bar)


;; Doom theme
;(require 'doom-themes)
;(setq doom-themes-enable-bold t
;      doom-themes-enable-italic t)

;; load theme
;(load-theme 'doom-one t)
;(add-hook 'find-file-hook 'doom-buffer-mode)  ; set doom-buffers to be 'brighter'
;(defvar doom-ui-theme 'doom-one)

;; enable flashig mode-line on errors
;(doom-themes-visual-bell-config)

;; enable custom neotree theme
;;(require 'doom-neotree)
;;(setq doom-neotree-enable-file-icons 'simple)

;; enable line numbers and highlight the current line
(global-linum-mode t)
(global-hl-line-mode 1)

(require 'all-the-icons)

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

;; Neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Join lines into one line
(global-set-key (kbd "M-j")
		(lambda ()
		  (interactive)
		  (join-line -1)))

;; --- Python configuration {{{
(elpy-enable)
(elpy-use-ipython)
;; --- }}}


;; =========================================
;; Various stuff atomatically added by Emacs
;; =========================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(ansi-term-color-vector
   [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(custom-safe-themes
   (quote
    ("4182c491b5cc235ba5f27d3c1804fc9f11f51bf56fb6d961f94788be034179ad" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8" default)))
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#d9d9d9")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(menu-bar-mode nil)
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (racket-mode nlinum doom-themes company-jedi elpy evil twilight-bright-theme)))
 '(vc-annotate-background "#1B2229")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#afaf6c")
    (cons 60 "#d7af79")
    (cons 80 "#ECBE7B")
    (cons 100 "#f1a179")
    (cons 120 "#e4946c")
    (cons 140 "#da8548")
    (cons 160 "#d78787")
    (cons 180 "#d787af")
    (cons 200 "#c678dd")
    (cons 220 "#e479af")
    (cons 240 "#f16c87")
    (cons 260 "#ff6c6b")
    (cons 280 "#bf5f5f")
    (cons 300 "#7f5f5f")
    (cons 320 "#3f5f5f")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
