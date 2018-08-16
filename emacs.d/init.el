   ;;; -*- lexical-binding: t -*-

   (defun tangle-init ()
     "If the current buffer is 'init.org' the code-blocks are
   tangled, and the tangled file is compiled."
     (when (equal (buffer-file-name)
                  (expand-file-name (concat user-emacs-directory "init.org")))
       ;; Avoid running hooks when tangling.
       (let ((prog-mode-hook nil))
         (org-babel-tangle)
         (byte-compile-file (concat user-emacs-directory "init.el")))))

   (add-hook 'after-save-hook 'tangle-init)

   (defun org-mode-export-links ()
     "Export links document to HTML automatically when 'links.org' is changed"
     (when (equal (buffer-file-name) "/Users/rakhim/org/links.org")
       (progn
     (org-html-export-to-html)
     (message "HTML exported"))))

   (add-hook 'after-save-hook 'org-mode-export-links)

   (set-frame-font "Menlo 14")
   (load-theme 'tsdh-light)
   (setq initial-frame-alist '((top . 50) (left . 100) (width . 125) (height . 45)))
   (tool-bar-mode -1)

   (setq show-paren-delay 0)
   (show-paren-mode 1)

   (global-visual-line-mode 1)

   (global-linum-mode 1)

   (setq-default frame-title-format "%b (%f)")

   (setq-default indent-tabs-mode nil)

   (setq auto-save-default nil)
   (setq make-backup-files nil)

   (fset 'yes-or-no-p 'y-or-n-p)

   (setq
     inhibit-startup-message t
     inhibit-startup-screen t
     echo-keystrokes 0.1
     initial-scratch-message nil
     initial-major-mode 'org-mode
     sentence-end-double-space nil
     confirm-kill-emacs 'y-or-n-p)

   (visual-line-mode 1)
   (scroll-bar-mode -1)
   (delete-selection-mode 1)
   (global-unset-key (kbd "s-p"))
   (global-hl-line-mode 1)

   ;; (setq mac-command-modifier 'control)
   ;; (setq mac-right-command-modifier 'control)
   ;; (setq mac-option-modifier 'meta)
   ;; (setq mac-control-modifier 'super)

   (setq ring-bell-function
         (lambda ()
           (let ((orig-fg (face-foreground 'mode-line)))
             (set-face-foreground 'mode-line "#F2804F")
             (run-with-idle-timer 0.1 nil
                                  (lambda (fg) (set-face-foreground 'mode-line fg))
                                  orig-fg))))

   (setq scroll-margin 10
      scroll-step 1
      next-line-add-newlines nil
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

   (setq mouse-wheel-follow-mouse 't)
   (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

   (require 'package)
   (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
       ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
       (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
       ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
       (when (< emacs-major-version 24)
       ;; For important compatibility libraries like cl-lib
   (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
   (package-initialize)

   (unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

   (use-package try
     :ensure t)

   (use-package nyan-mode
     :ensure t
     :commands nyan-mode
     :config
     (nyan-mode))

   (use-package exec-path-from-shell
     :ensure t
     :commands exec-path-from-shell-initialize
     :config
       (when (memq window-system '(mac ns x))
         (exec-path-from-shell-initialize)))

   (use-package expand-region
     :ensure t)

   (require 'helm)
   (use-package helm
     :ensure t
     :config
     (require 'helm-config)
     (helm-mode 1)
     (helm-autoresize-mode 1)
     (setq helm-follow-mode-persistent t)
     (global-set-key (kbd "M-x") 'helm-M-x)
     (setq helm-M-x-fuzzy-match t)
     (global-set-key (kbd "M-y") 'helm-show-kill-ring)
     (global-set-key (kbd "s-b") 'helm-mini)
     (global-set-key (kbd "C-x C-f") 'helm-find-files)
     (global-set-key (kbd "s-f") 'helm-occur))

   (require 'projectile)
   (use-package projectile
     :ensure t
     :config
     (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
     (projectile-mode +1)
     )

   (require 'helm-projectile)
   (use-package helm-projectile
     :ensure t
     :config
     (helm-projectile-on))

   (use-package helm-ag
     :ensure t
     :config
     (global-set-key (kbd "s-F") 'helm-projectile-ag))

   (use-package simpleclip
     :ensure t
     :commands
     (simpleclip-mode)
     :config
     (simpleclip-mode 1))

   (use-package magit
     :ensure t
     :config
     (global-set-key (kbd "s-m") 'magit-status))

   (require 'beacon)
   (use-package beacon
     :ensure t
     :config
     (beacon-mode 1))

   (require 'which-key)
   (use-package which-key
     :ensure t
     :config
     (which-key-mode)
     (setq which-key-idle-delay 0.6))

   (setq ispell-program-name "aspell")

    (use-package yaml-mode
      :ensure t)

   (global-set-key (kbd "s-<backspace>") 'kill-whole-line)

   (global-set-key (kbd "s-<right>") (kbd "C-e"))
   (global-set-key (kbd "S-s-<right>") (kbd "C-S-e"))
   (global-set-key (kbd "s-<left>") (kbd "M-m"))
   (global-set-key (kbd "S-s-<left>") (kbd "M-S-m"))

   (global-set-key (kbd "s-<up>") (kbd "M-v"))
   (global-set-key (kbd "s-<down>") (kbd "C-v"))

   (global-set-key (kbd "s-o") (kbd "C-x o"))
   (global-set-key (kbd "s-1") (kbd "C-x 1"))
   (global-set-key (kbd "s-2") (kbd "C-x 2"))
   (global-set-key (kbd "s-3") (kbd "C-x 3"))
   (global-set-key (kbd "s-3") (kbd "C-x 3"))
   (global-set-key (kbd "s-0") (kbd "C-x 0"))
   (global-set-key (kbd "s-w") (kbd "C-x 0"))
   (global-set-key (kbd "s-t") (kbd "C-x 3"))

   (defun smart-open-line ()
     "Insert an empty line after the current line. Position the cursor at its beginning, according to the current mode."
     (interactive)
     (move-end-of-line nil)
     (newline-and-indent))

   (defun smart-open-line-above ()
     "Insert an empty line above the current line. Position the cursor at it's beginning, according to the current mode."
     (interactive)
     (move-beginning-of-line nil)
     (newline-and-indent)
     (forward-line -1)
     (indent-according-to-mode))

   (global-set-key (kbd "s-<return>") 'smart-open-line)
   (global-set-key (kbd "s-S-<return>") 'smart-open-line-above)

   (add-hook 'before-save-hook 'delete-trailing-whitespace)
   (setq require-final-newline t)

  (setq org-directory "~/org")

  (setq org-agenda-files '("~/org"))

  (setq org-support-shift-select t)

  (eval-after-load 'org
    '(progn
      (add-to-list 'org-structure-template-alist '("el" "#+BEGIN_SRC emacs-lisp \n?\n#+END_SRC"))
      (define-key org-mode-map (kbd "C-'") nil)
      (global-set-key "\C-ca" 'org-agenda)
      (global-set-key (kbd "s-'") 'er/expand-region)))

  (setq org-edit-src-content-indentation 0)
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation t)

  (setq org-src-fontify-natively t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (yaml-mode magit simpleclip helm-ag which-key use-package try org-bullets nyan-mode helm-projectile expand-region exec-path-from-shell beacon))))

  (find-file "~/org/main.org")

  (setq org-log-into-drawer t)

  (global-set-key (kbd "\e\em") (lambda () (interactive) (find-file "~/org/main.org")))
  (global-set-key (kbd "\e\ec") (lambda () (interactive) (find-file "~/.emacs.d/init.org")))
  (global-set-key (kbd "\e\el") (lambda () (interactive) (find-file "~/org/links.org")))

  (setq org-cycle-separator-lines 1)

  (require 'org-bullets)
  (use-package org-bullets
    :ensure t
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
