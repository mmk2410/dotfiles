;; Emacs configuration
;; Marcel Kapfer (C) 2016 - 2018
;; MIT License

;; -----------------------------------------------------------------------------

;; Package configuration
;;
;; This configuration uses use-package, so we're first ensuring, that it is
;; installed using the emacs package system an MELPA.

(package-initialize)

(require 'package)
(setq package-enable-on-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.milkbox.net/packages/"))

;; install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq
 ;; tell use-package to always ensure
 use-package-always-ensure t
 ;; don't load outdated packages
 load-prefer-newer t)

;; -----------------------------------------------------------------------------

;; Basic configuration
;;
;; The code in this block should be package independend.

;; Keep emacs Custom-settings in separate file
;; set the file path
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; create the file if not existent
(when (not (file-exists-p custom-file))
  (with-temp-buffer (write-file custom-file)))

;; finally load it
(load custom-file)

;; set name and e-mail
(setq user-full-name "Marcel Kapfer"
      user-mail-address "opensource@mmk2410.org")

;; y/n instead of yes/no for confirm questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save backup files in ~/.emacs-autosaves/
(defvar user-temporary-file-directory "~/.emacs-autosaves")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . ,user-temporary-file-directory)
                               (tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))

;; set default input encoding
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")

;; disable startup screen
(setq inhibit-startup-screen t)

;; visual bell instead of BEEP
(setq visible-bell 1)

;; set text in scratch to nil
(setq initial-scratch-message nil)

;; Don't truncate lines
(setq truncate-lines nil)

;; Set default connection method for TRAMP
(setq tramp-default-method "ssh")

;; Maximize threshold for garbage collection to 10MB for less gc
(setq gc-cons-treshold (* 10 1024 1024))

;; confirm before closing emacs
(setq confirm-kill-emacs #'y-or-n-p)

;; activate winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Highlight the current line
(global-hl-line-mode t)

;; replace selected text by typing
(delete-selection-mode t)

;; ibuffer configuration
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("org" (name . "^.*org$"))
               ("shell" (or (mode . eshell-mode) (mode . term-mode)))
               ;; ("mu4e" (or
               ;;          (mode . mu4e-compose-mode)
               ;;          (name . "\*mu4e\*")
               ;;          ))
               ("programming" (or
                               (mode . python-mode)
                               (mode . sh-mode)
                               (mode . web-mode)
                               (mode . emacs-lisp-mode)
                               (mode . lisp-mode)
                               (mode . dart-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

;; put a new line at the end of every file
(setq require-final-newline t)

;; delete trailing whitespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; use german directory in ispell
(setq ispell-dictionary "german-new8")

;;; always follow symlinks to git repos
(setq vc-follow-symlinks t)

;;; set default column width
(setq-default fill-column 80)

;;; hide tool bar, menu bar and scroll bar
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;; indent using spaces, not tabs
(setq indent-tabs-mode nil)

;; tab width
(setq tab-width 2)

;; Connecting StumpWM with emacsclient
(add-hook 'after-init-hook 'server-start)
(setq server-raise-frame t)
(if window-system
    (add-hook 'server-done-hook
	      (lambda ()
		(shell-command
		 "stumpish 'eval (stumpwm::return-es-called-win stumpwm::*es-win*)'"))))

;; auto-fill mode
(add-hook 'mail-mode-hook 'auto-fill-mode)
(add-hook 'mail-mode-hook (lambda () (setq fill-column 72)))

;; set default web browser
(setq browse-url-generic-program
      (substring (shell-command-to-string "gconftool-2 -g /desktop/gnome/url-handlers/https/command") 0 -4)
      browse-url-browser-function 'browse-url-generic)

;; set font
(set-frame-font "Fira Code 8" nil t)

;; -----------------------------------------------------------------------------

;; Custom keybindings
;;
;; here are custom keybindings for emacs or package functions configured. Custom
;; bindings for own functions are set directly after the function declaration.

;; global keys

;; Emacs Shell
(global-set-key (kbd "C-c e") 'eshell)

;; Async shell command
(global-set-key (kbd "C-c a") 'async-shell-command)

;; Open link under cursor
(global-set-key (kbd "C-c b") 'browse-url-at-point)

;; start ansi-term with fish shell
(global-set-key (kbd "C-c s") (lambda () (interactive) (ansi-term "/usr/bin/fish")))

;; eval region
(global-set-key (kbd "C-C x") 'eval-region)

;; revert buffer (reload file from disk)
(global-set-key (kbd "<f5>" ) 'revert-buffer)

;; use ibuffer as default
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; toggle auto-fill-mode
(global-set-key (kbd "C-c q") 'auto-fill-mode)

;; package and mode specific keys

;; paste in term using C-x C-y
(eval-after-load "term" '(define-key term-raw-map (kbd "C-y") 'term-paste))

;; -----------------------------------------------------------------------------

;; Custom functions
;;
;; custom functions are defined here, sorted by use-case (if possible)

;; general

;; function for closing all buffers
(defun close-all-buffers ()
  "Close all buffers"
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;; shortcut for close-all-buffers
(global-set-key (kbd "C-c c") 'close-all-buffers)


;; LaTeX

;; helper for a new (La)TeX style guide concept.
(defun TeX-insert-comment-line ()
  "Insert a linebreak followed by a '%' and another line break"
  (interactive)
  (newline-and-indent)
  (insert "%")
  (newline-and-indent))

;; Key binding for TeX-insert-comment-line
(defun my-latex-mode-keys ()
  "Key bindings for latex-mode"
  (local-set-key (kbd "<C-return>") 'TeX-insert-comment-line))

;; Enable own latex-mode keybindings
(add-hook 'TeX-mode-book 'my-latex-mode-keys)

;; -----------------------------------------------------------------------------

;; Packages and package configuration
;;
;; all packages should be loaded with use-package

;; which-key
;; Display available keybindings in popup

(use-package which-key
  :config
  (which-key-mode))

;; org-bullets
;; Show bullets in org-mode as UTF-8 characters
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; undo-tree
;; Treat undo history as a tree
(use-package undo-tree
  :config
  (global-undo-tree-mode))

;; beacon
;; Highlight the cursor whenever the window scrolls
(use-package beacon
  :config
  (beacon-mode))

;; hungry-delete
;; Delete a whitespace character will delete all whitespace until the next
;; non-whitespace character
(use-package hungry-delete
  :config
  (global-hungry-delete-mode t))

;; expand-region
;; Increase selected region by semantic units.
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; dired+
;; Extensions to Dired
(use-package dired+
  :config
  (require 'dired+))

;; projectile
;; Manage and navigate projects in Emacs easily
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

;; smartparens
;; Automatic insertion, wrapping and paredit-like navigation with user defined
;; pairs.
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

;; dumb-jump
;; jump to definition for multiple languages without configuration.
(use-package dumb-jump
  :config
  (dumb-jump-mode t))

;; origami
;; Flexible text folding
(use-package origami)

;; multiple-cursors
;; Multiple cursors for Emacs
(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-*" . mc/mark-all-like-this)
   ("C-;" . mc/edit-lines)))

;; pcre2el
;; regexp syntax converter
(use-package pcre2el
  :config
  (pcre-mode t))

;; visual-regexp
;; A regexp/replace command for Emacs with interactive visual feedback
(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)
   ("C-c m" . vr/mc-mark)))

;; mu4e-maildirs-extension
;; Show mu4e maildirs summary in mu4e-main-view
(use-package mu4e-maildirs-extension
  :config
  (mu4e-maildirs-extension))

;; mu4e-alert
;; Desktop notification for mu4e
(use-package mu4e-alert
  :config
  (mu4e-alert-set-default-style 'libnotify)
  (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
  (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display))

;; indent-guide
;; show vertical lines to guide indentation
(use-package indent-guide
  :config
  (indent-guide-global-mode))

;; nlinum
;; Show line numbers in the margin
(use-package nlinum
  :config
  (global-nlinum-mode t))


;; org
;; Outline-based notes management and organizer
(use-package org
  :config
  ;; enable org mod efor all org files
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

  ;; add scrartcl LaTeX class to org
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
		 '("scrartcl"
		   "\\documentclass{scrartcl}"
		   ("\\section{%s}" . "\\section*{%s}")
		   ("\\subsection{%s}" . "\\subsection*{%s}")
		   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		   ("\\paragraph{%s}" . "\\paragraph*{%s}")
		   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

  ;; add latex packages and configurations
  (setq org-latex-packages-alist
        '(
          ("" "booktabs" t)
          ("" "listings" t)
          ("" "xcolor" t)
          ("" "polyglossia" t)
          ("utf8" "luainputenc" t)
          ("" "fontspec" t)
          ("hidelinks" "hyperref" t)
          ("" "libertineotf" t)
          ("scale=0.9" "AnonymousPro" t)
          "\\setmainfont{Linux Libertine O}"
          "\\setsansfont{Linux Biolinum O}"
          "\\setmonofont{AnonymousPro}"
          "\\addtokomafont{disposition}{\\fontspec{LinBiolinum_RB}}"
          "\\setdefaultlanguage{german}"))

  ;; enable latex listings
  (setq org-latex-listings 'listings)

  ;; latex listings options
  (setq org-latex-listings-options
        '(
          ("frame" "single")
          ("rulesep" "6pt")
          ("backgroundcolor" "\\color{gray!20}")
          ("basicstyle" "\\footnotesize\\ttfamily")
          ("breaklines" "true")
          ))

  ;; remove unused default packages
  (unless (boundp 'org-latex-default-packages-alist)
    (setq org-latex-default-packages-alist nil))
  (setq org-latex-default-packages-alist
        (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))
  (setq org-latex-default-packages-alist
        (remove '("" "fixltx2e" nil) org-latex-default-packages-alist))
  (setq org-latex-default-packages-alist
        (remove '("" "hyperref" nil) org-latex-default-packages-alist))
  (setq org-latex-default-packages-alist
        (remove '"\\tolerance=1000" org-latex-default-packages-alist))

  ;; syntax highlighting
  (setq org-src-fontify-natively t)
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)))

;; fill-column-indicator
;; Graphically indicate the fill column
(use-package fill-column-indicator
  :config
  ;; set rule width to 5px
  (setq fci-rule-width 5)
  (setq fci-rule-color "#5B6268"))

;; diff-hl
;; Highlight uncommitted changes using VC
(use-package diff-hl
  :config
  (global-diff-hl-mode t)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; treemacs
;; A tree style file explorer package
(use-package treemacs
  :defer t
  :init
  (define-prefix-command 'treemacs-map)
  (global-set-key (kbd "M-m") 'treemacs-map)
  :config
  (setq treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-integration            t
        treemacs-collapse-dirs              (if (executable-find "python") 3 0)
        treemacs-silent-refresh             nil
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil
        treemacs-is-never-other-window      nil
        treemacs-goto-tag-strategy          'refetch-index)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind
  (:map global-map
        ("<f9>"         . treemacs-toggle)
        ("M-0"        . treemacs-select-window)
        ("C-c 1"      . treemacs-delete-other-windows)
        ("M-m ft"     . treemacs-toggle)
        ("M-m fT"     . treemacs)
        ("M-m fB"     . treemacs-bookmark)
        ("M-m f C-t"  . treemacs-find-file)
        ("M-m f M-t" . treemacs-find-tag)))

;; treemacs-projectile
;; Projectile integration for treemacs
(use-package treemacs-projectile
  :defer t
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
  :bind
  (:map global-map
        ("M-m fP" . treemacs-projectile)
        ("M-m fp" . treemacs-projectile-toggle)))

;; magit
;; A Git porcelain inside Emacs
(use-package magit
  :bind
  ("C-x g" . magit-status))

;; rainbox-delimiters
;; Highlight brackets according to their depth
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; powerline
;; Rewrite of Powerlinen
(use-package powerline
  :config
  (powerline-center-theme))

;; doom-themes
;; an opinionated pack of modern color-themes
(use-package doom-themes
  :config
  (progn
    ;; enable bold and italic
    (setq doom-themes-enable-bold t
	  doom-themes-enable-italic t)

    ;; enable doom one theme
    (load-theme 'doom-one :no-confirm)

    ;; enable flashing mode-line on errors
    (doom-themes-visual-bell-config)))

;; pdf-tools
;; Support library for PDF documents.
(use-package pdf-tools
  :config
  (pdf-tools-install)
  ;; nlinum makes no problems for me
  ;; so disabling the warning
  (setq pdf-view-incompatible-modes
   (quote
    (linum-mode linum-relative-mode helm-linum-relative-mode nlinum-hl-mode nlinum-relative-mode yalinum-mode))))

;; counsel
;; Various completion functions using Ivy
(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("<f1> f" . counsel-describe-function)
   ("<f1> v" . counsel-describe-variable)
   ("<f1> l" . counsel-find-library)
   ("<f2> i" . counsel-info-lookup-symbol)
   ("<f2> u" . counsel-unicode-char)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-ag)
   ("C-x l" . counsel-locate)
   ("C-S-o" . counsel-rhythmbox)))

;; ivy
;; Incremental Vertical completYon
(use-package ivy
  :diminish (ivy-mode)
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-display-style 'fancy)
  (setq ivy-extra-directories nil)
  :bind
  (("C-c C-r" . ivy-resume)))

;; swiper
;; Isearch with an overview. Oh, man!
(use-package swiper
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (setq ivy-extra-directories nil)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)))

;; counsel-projectile
;; Ivy UI for Projectile
(use-package counsel-projectile
  :config
  (counsel-projectile-on))

;; avy
;; Jump to arbitrary positions in visible text and select text quickly.
(use-package avy
  :bind
  (("s-s" . avy-goto-char)))

;; smooth-scrolling
;; Make emacs scroll smoothly
(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode t)
  (setq smooth-scroll-margin 5))

;; ox-pandoc
;; org exporter for pandoc
(use-package ox-pandoc
  :config
  (setq org-pandoc-options-for-latex-pdf '((latex-engine . "lualatex")))
  (setq org-pandoc-options-for-beamer-pdf '((latex-engine . "lualatex"))))

;; org-trello
;; Minor mode to synchronize org-mode buffer and trello board
(use-package org-trello)

;; web-beautify
;; Format HTML, CSS and JavaScript/JSON
(use-package web-beautify
  :bind
  (:map js2-mode-map ("C-c b" . web-beautify-js)
        :map json-mode-map ("C-c b" . web-beautify-js)
        :map html-mode-map ("C-c b" . web-beautify-html)
        :map css-mode-map ("C-c b" . web-beautify-css)))

;; company
;; Modular text completion framework
(use-package company
  :init
  (global-company-mode t)
  :config
  (setq company-show-numbers t))

;; company-math
;; Completion backends for unicode math symbols and latex tags
(use-package company-math
  :config
  (add-hook 'TeX-mode-hook (lambda ()
                             (setq-local company-backends
                                         (append '((company-math-symbols-latex company-latex-commands))
                                                 company-backends)))))

;; beginend
;; Redefine M-< and M-> for some modes
(use-package beginend
  :config
  (beginend-global-mode t))

;; markdown-mode
;; Major mode for Markdown-formatted text
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; markdown-preview-mode
;; markdown realtime preview minor mode
(use-package markdown-preview-mode
  :config
  (add-to-list 'markdown-preview-javascript "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"))

;; web-mode
;; major mode for editing web templates
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2))

;; dart-mode
;; Major mode for editing Dart files
(use-package dart-mode)

;; csv-mode
;; Major mode for editing comma/char separated values
(use-package csv-mode
  :config
  (setq csv-separators '(";")))

;; json-mode
;; Major mode for editing JSON files
(use-package json-mode)

;; focus
;; Dim the font color of text in surrounding sections
(use-package focus)

;; phpunit
;; Launch PHP unit tests using phpunit
(use-package phpunit
  :bind
  (:map web-mode-map
        ("C-x t" . phpunit-current-test)
        ("C-x c" . phpunit-current-class)
        ("C-x p" . phpunit-current-project)))

;; php-mode
;; Major mode for editing PHP files
(use-package php-mode)

;; fish-mode
;; Major mode for fish shell scripts
(use-package fish-mode)

;; easy-hugo
;; Write blogs made with hugo by markdown or org-mode
(use-package easy-hugo)

;; stumpwm-mode
;; special lisp mode for evaluating code into running stumpwm
(use-package stumpwm-mode)

;; slime
;; Superior Lisp Interaction Mode for Emacs
(use-package slime
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;; slime-company
;; slime completion backend for company mode
(use-package slime-company
  :config
  (setq slime-contribs '(slime-fancy slime-company)))

;; yaml-mode
;; Major mode for editing YAML files
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; sass-mode
;; Major mode for editing Sass files
(use-package sass-mode)

;; coffee-mode
;; Major mode for CoffeeScript code
(use-package coffee-mode
  :config
  (setq whitespace-action '(auto-cleanup))
  (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))
  (setq coffee-tab-width 2)
  (add-hook 'coffee-mode-hook 'whitespace-mode))

;; python
;; Python's flying circus support for Emacs
(use-package python
  :config
  (setq flycheck-python-pylint-executable "pylint3"))

;; sr-speedbar
;; Same frame speedbar
(use-package sr-speedbar
  :bind (("s-b" . sr-speedbar-toggle)))

;; mu4e
;; emacs mail client
(use-package mu4e
  :load-path "/usr/share/emacs25/site-lisp/mu4e/"
  :ensure nil
  :pin manual
  :config
  ;; get mail
  (setq
   mu4e-get-mail-command "offlineimap"
   mu4e-update-interval 300)

  ;; faster reindexing
  (setq
   mu4e-maildir-index-cleanup nil
   mu4e-index-lazy-check t)

  ;; smtpmail settings
  (setq  message-send-mail-function 'smtpmail-send-it
	 send-mail-function 'smtpmail-send-it)

  ;; don't save sent messages to "Sent" folder
  (setq mu4e-sent-messages-behavior 'delete)

  ;; use mu4e as default emacs mailer
  (setq mail-user-agent 'mu4e-user-agent)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  ;; complete date format
  (setq mu4e-headers-date-format "%Y-%m-%d %H:%M")

  ;; show full addresses
  (setq mu4e-view-show-addresses 't)

  ;; attachment directory
  (setq mu4e-attachment-dir  "/tmp")

  ;; maildir
  (setq mu4e-maildir "~/.mail")

  ;; don't reply to myself
  (setq mu4e-compose-dont-reply-to-self t)

  ;; list of email addresses
  (setq mu4e-user-mail-address-list '("marcel.kapfer@uni-ulm.de"
				      "marcel@marcel-kapfer.de"
				      "tex@mmk2410.org"
				      "me@mmk2410.org"
				      "debian@mmk2410.org"
				      "hugo@marcel-kapfer.de"
				      "info@marcel-kapfer.de"
				      "contact@marcel-kapfer.de"
				      "kontakt@marcel-kapfer.de"
				      "opensource@mmk2410.org"))

  ;; customize mu4e list view
  (setq mu4e-headers-fields '((:human-date . 20)
			      (:flags . 6)
			      (:mailing-list . 10)
			      (:from-or-to . 22)
			      (:subject . nil)))

  ;; convenience function for starting the whole mu4e in its own frame
  ;; posted by the author of mu4e on the mailing list
  (defun mu4e-in-new-frame ()
    "Start mu4e in new frame."
    (interactive)
    (select-frame (make-frame))
    (mu4e))

  ;; spell checking
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)

  ;; use correct account context when sending mail based from headers
  (setq message-sendmail-envelope-from 'header)

  ;; set citation line
  (setq message-citation-line-format "%f on %Y-%m-%d %H:%M %Z:\n")
  (setq message-citation-line-function 'message-insert-citation-line)

  ;; mu4e contexts / mail identities
  (setq mu4e-contexts
	`( ,(make-mu4e-context
	     :name "University"
	     :enter-func (lambda () (mu4e-message "University Context"))
	     :match-func (lambda (msg)
			   (when msg
			     (string-prefix-p "/university" (mu4e-message-field msg :maildir))))
	     :vars '((user-mail-address . "marcel.kapfer@uni-ulm.de")
		     (user-full-name . "Marcel Kapfer")
		     (message-signature-file . "~/dotfiles/mutt/sig-uni")
		     ;; smtp
		     (smtpmail-stream-type . starttls)
		     (smtpmail-default-smtp-server . "smtp.uni-ulm.de")
		     (smtpmail-smtp-server . "smtp.uni-ulm.de")
		     (smtpmail-smtp-user . "ftu15")
		     (smtpmail-smtp-service . 587)
		     ;; folders
		     (mu4e-sent-folder . "/university/Sent")
		     (mu4e-drafts-folder . "/university/Drafts")
		     (mu4e-trash-folder . "/university/Trash")
		     (mu4e-refile-folder . "/university/Archives")))
	   ,(make-mu4e-context
	     :name "Mailbox"
	     :enter-func (lambda () (mu4e-message "Mailbox Context"))
	     :match-func (lambda (msg)
			   (when msg
			     (string-prefix-p "/mailbox" (mu4e-message-field msg :maildir))))
	     :vars '((user-mail-address . "marcel.kapfer@mailbox.org")
		     (user-full-name . "Marcel Kapfer")
		     (message-signature-file . "~/dotfiles/mutt/sig")
		     ;; smtp
		     (smtpmail-stream-type . ssl)
		     (smtpmail-smtp-server . "smtp.mailbox.org")
		     (smtpmail-smtp-user . "marcel.kapfer@mailbox.org")
		     (smtpmail-smtp-service . 465)
		     ;; folders
		     (mu4e-sent-folder . "/mailbox/Sent")
		     (mu4e-drafts-folder . "/mailbox/Drafts")
		     (mu4e-trash-folder . "/mailbox/Trash")
		     (mu4e-refile-folder . "/mailbox/Archives")))))

  ;; custom bookmarks
  (setq mu4e-bookmarks (delete '("flag:unread AND NOT flag:trashed" "Unread messages" 117) mu4e-bookmarks))

  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Unread Messages"
		:query "maildir:/university* flag:unread AND NOT flag:trashed OR maildir:/mailbox/inbox flag:unread AND NOT  flag:trashed"
		:key ?u))
  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Flagged messages"
		:query "flag:flagged"
		:key ?f))

  ;; custom shortcuts
  (setq mu4e-maildir-shortcuts
	'(("/university/inbox" . ?u)
	  ("/university/fin.fin" . ?f)
	  ("/university/fin.intern" . ?i)
	  ("/mailbox/inbox" . ?m)
	  ("/mailbox/debian.devel-changes" . ?c)
	  ("/mailbox/debian.user" . ?d)))

  ;; always add myself as BCC
  (add-hook 'mu4e-compose-mode-hook
	    (lambda ()
	      "Add a BCC header"
	      (save-excursion (message-add-header (concat "Bcc: " user-mail-address "\n")))
	      ;; sign message
	      (mml-secure-message-sign-pgpmime))))

;; elfeed
;; emacs feed reader
(use-package elfeed
  :bind
  (("C-x w" . elfeed))
  :config
  (defun elfeed-search-format-date (date)
    (format-time-string "%Y-%m-%d %H:%M" (seconds-to-time date))))


;; bug-hunter
;; Hunt down errors by bisecting elisp files
(use-package bug-hunter)

;; desktop
;; Save buffers, windows and frames
(use-package desktop
  :disabled t
  :init (desktop-save-mode)
  :config
  ;; Save desktops a minute after Emacs was idle.
  (setq desktop-auto-save-timeout 60)

  ;; Don't save Magit and Git related buffers
  (dolist (mode '(magit-mode magit-log-mode))
    (add-to-list 'desktop-modes-not-to-save mode))
  (add-to-list 'desktop-files-not-to-save (rx bos "COMMIT_EDITMSG")))

;; hl-todo
;; highlight TODOs and similar keywords
(use-package hl-todo
  :defer t
  :init (global-hl-todo-mode))

;; yasnippets
;; Yet another snippet extension for Emacs.
(use-package yasnippet
  :defer t)

;; company-quickhelp
;; Documentation popup for Company
(use-package company-quickhelp
  :init
  (company-quickhelp-mode 1)
  :config
  (setq company-quickhelp-delay 0.5))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-site
  ;; AUCTeX initialization
  :ensure auctex)

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex
  :ensure auctex
  :defer t
  :config
  (setq
   ;; Parse file after loading it if no style hook is found for it.
   TeX-parse-self t
   ;; Automatically save style information when saving the buffer.
   TeX-auto-save t
   ;; Automatically interst braces after sub- and superscript in math mode
   TeX-electric-sub-and-superscript t
   ;; Don't ask the user when saving a file for each file.
   TeX-save-query nil
   ;; enable synctex correlation.
   TeX-source-correlate-mode t
   TeX-source-correlate-start-server t
   ;; use pdf-tools with synctex
   TeX-view-program-selection '((output-pdf "PDF Tools"))
   TeX-source-correlate-start-server t
   )
  (setq-default TeX-master nil
		TeX-engine 'luatex))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-buf
  :ensure auctex
  :defer t
  ;; Don't ask for confirmation when saving before processing
  :config (setq TeX-save-query nil))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-style
  :ensure auctex
  :defer t
  :config
  ;; Enable support for csquotes
  (setq LaTeX-csquotes-close-quote "}"
	LaTeX-csquotes-open-quote "\\enquote{"))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-fold
  :ensure auctex
  :defer t
  :init (add-hook 'TeX-mode-hook #'TeX-fold-mode))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-mode
  :ensure auctex
  :defer t)

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package latex
  :ensure auctex
  :defer t
  :config
  ;; No language-specific hyphens please
  (setq LaTeX-babel-hyphen nil)
  ;; Easy math input
  (add-hook 'TeX-mode-hook #'LaTeX-math-mode)
  ;; Start flyspell
  (add-hook 'TeX-mode-hook #'flyspell-mode)
  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
            #'TeX-revert-document-buffer)
  ;; hooks for outline mode
  (add-hook 'TeX-mode-hook #'outline-minor-mode)
  ;; reload pdf document after compliation
  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  ;; hook for rainbox delimiters mode
  (add-hook 'TeX-mode-hook #'rainbow-delimiters-mode)
  ;; start fci-mode
  (add-hook 'TeX-mode-hook #'fci-mode)
  ;; start auto-fill mode
  (add-hook 'TeX-mode-hook #'auto-fill-mode))

;; bibtex
;; BibTeX editing
(use-package bibtex
  :defer t
  :config
  ;; Run prog mode hooks for bibtex
  (add-hook 'bibtex-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

  ;; Use a modern BibTeX dialect
  (bibtex-set-dialect 'biblatex))

;; reftex
;; TeX cross-reference management
(use-package reftex
  :defer t
  :diminish reftex-mode
  :init (add-hook 'LaTeX-mode-hook #'reftex-mode)
  :config
  (setq
   ;; Plug into AUCTeX
   reftex-plug-into-AUCTeX t
   ;; Automatically derive labels, and prompt for confirmation
   reftex-insert-label-flags '(t t)))

;; term / ansi-term
;; terminal in emacs
(use-package term
  :defer t
  :init (defalias 'sh 'ansi-term)
  :config
  ;; set default shell
  ;; from https://ogbe.net/emacsconfig.html
  (defvar my-term-shell "/usr/bin/fish")
  (defadvice ansi-term (before force-bash)
    (interactive (list my-term-shell)))
  (ad-activate 'ansi-term)

  ;; close ansi-term, when shell session exists
  ;; from https://ogbe.net/emacsconfig.html
  (defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
    (if (memq (process-status proc) '(signal exit))
	(let ((buffer (process-buffer proc)))
	  ad-do-it
	  (kill-buffer buffer))
      ad-do-it))
  (ad-activate 'term-sentinel)

  ;; disable nlinum in shell
  (add-hook 'term-mode-hook (lambda () (nlinum-mode -1))))
