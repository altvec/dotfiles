;; Emacs configuration file -*- no-byte-compile: t -*-
;;

(setq
 ;; User details
 user-full-name "Sergey Kalistratov"
 user-email-address "me@sergeykalistratov.com"
 
 ;; Always load newest byte code
 load-prefer-newer t

 ;; Reduce the frequency of garbage collection by making it happen on
 ;; each 50MB of allocated data (the default is on every 0.76MB)
 gc-cons-threshold 50000000

 ;; Disable welcome screen and stuff
 inhibit-startup-message t
 inhibit-splash-screen t
 inhibit-startup-echo-area-message t

 ;; Don't attempt to load `default.el`
 inhibit-default-init t

 ;; Keys bindings
 ;; See http://whattheemacsd.com/ for details
 mac-command-modifier 'meta
 mac-option-modifier 'super
 ns-function-modifier 'hyper
 mac-mouse-wheel-smooth-scroll t)

;; Set default language
(set-language-environment "utf-8")

(setq-default
 ;; Don't crap in my init file
 custom-file (locate-user-emacs-file "custom.el")

 ;; Do not use tabs
 indent-tabs-mode nil
 ;; When using tabs (Go), make them 4 spaces long
 tab-width 2
 ;; Don't wrap long lines
 truncate-lines t)


;; UI
;; Remove GUI elements
(dolist (mode '(blink-cursor-mode
                menu-bar-mode
                tool-bar-mode
                tooltip-mode
                scroll-bar-mode))
  (when (fboundp mode)
    (funcall mode -1)))

(setq
 ;; No bells and whistles of any kind
 ring-bell-function (lambda())
 visible-bell nil

 ;; Improved scrolling when using touchpad
 mouse-wheel-follow-mouse 't
 mouse-wheel-scroll-amount '(1 ((shift) . 1)))


;; Packages
(with-no-warnings
  (require 'package))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize nil)

(unless package-archive-contents
  (package-refresh-contents))


;; Set paths
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(exec-path-from-shell-copy-env "PATH")

(setq default-directory (expand-file-name "~/"))
(defconst local-temp-dir (expand-file-name (locate-user-emacs-file "temp"))
  "Folder for temp files to be stored.")


(defvar myPack
  '(better-defaults
    auto-compile
    exec-path-from-shell
    evil
    twilight-bright-theme
    doom-themes
    solaire-mode
    all-the-icons
    neotree
    slime
    org-bullets
    python-mode))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPack)

;; EVIL mode
(require 'evil)
(evil-mode 1)

;; Auto-compile
(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

;; Essentials
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)

;; Initial window settings
(setq initial-frame-alist
      '((width . 92)
	(height . 54)))


;; --- Theme and Appearance {{
(set-face-attribute 'default nil :family "Fira Code")
(setq-default line-spacing 3)
(set-face-attribute 'default nil :height 130)
(setq-default cursor-type 'bar)

(require 'all-the-icons)
(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme 'doom-molokai t)
(add-hook 'find-file-hook 'solaire-mode)  ; set doom-buffers to be 'brighter'
;(defvar doom-ui-theme 'doom-dark)

(doom-themes-visual-bell-config)
(doom-themes-neotree-config)
(doom-themes-org-config)

;; enable line numbers and highlight the current line
(global-linum-mode t)
(global-hl-line-mode 1)
(unless window-system
  (add-hook 'linum-before-numbering-hook
	    (lambda ()
	      (setq-local linum-format-ftm
			  (let ((w (length (number-to-string
					    (count-lines (point-min) (point-max))))))
			    (concat "%" (number-to-string w) "d"))))))
(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-ftm line) 'face 'linum)
   (propertize " " 'face 'mode-line)))
(unless window-system
  (setq linum-format 'linum-format-func))
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

;; --- LISP {{{
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contrib '(slime-fancy))
;; --- }}}

;; --- Org mode {{{
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(org-babel-do-load-languages
 'org-label-load-languages
 '(
   (lisp . t)
   ))
;; --- }}}
