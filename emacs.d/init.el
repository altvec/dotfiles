;; Emacs configuration file
;;

;; ---  Tweaks {{

;; Always load newest byte code
(setq load-prefer-newer t)

;; Reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; Don't litter my init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

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
    jedi
    twilight-bright-theme
    doom-themes
    solaire-mode
    all-the-icons
    neotree
    slime
    org-bullets
    ob-ipython
    python-mode))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPack)

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
(set-face-attribute 'default nil :family "Operator Mono Light")
(setq-default line-spacing 3)
(set-face-attribute 'default nil :height 120)
(setq-default cursor-type 'bar)

(require 'all-the-icons)
(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme 'doom-molokai t)
(add-hook 'find-file-hook 'solaire-mode)  ; set doom-buffers to be 'brighter'
(defvar doom-ui-theme 'doom-molokai)

(doom-themes-visual-bell-config)

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

;; --- Python configuration {{{
(require 'jedi)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(add-hook 'python-mode-hook 'jedi:setup)

(elpy-enable)
(elpy-use-ipython)
;; --- }}}

;; --- LISP {{{
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contrib '(slime-fancy))
;; --- }}}

;; --- Org mode {{{
(require 'org-bullets)
(require 'ob-ipython)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(org-babel-do-load-languages
 'org-label-load-languages
 '((ipython . t)
   (lisp . t)
   ))
;; --- }}}
