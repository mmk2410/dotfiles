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
(setq backup-by-copying t
      backup-directory-alist `(("." . ,user-temporary-file-directory)
                               (tramp-file-name-regexp nil))
      auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-")
      auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))

;; set default input encoding
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")

;; general options
(setq
 ;; disable startup screen
 inhibit-startup-screen t
 ;; visual bell instead of BEEP
 visible-bell 1
 ;; set text in scratch to nil
 initial-scratch-message nil
 ;; Don't truncate lines
 truncate-lines nil
 ;; Maximize threshold for garbage collection to 10MB for less gc
 gc-cons-treshold (* 10 1024 1024)
 ;; confirm before closing emacs
 confirm-kill-emacs #'y-or-n-p
 ;; put a new line at the end of every file
 require-final-newline t
 ;; use german directory in ispell
 ispell-dictionary "german"
;;; always follow symlinks to git repos
 vc-follow-symlinks t
 ;;; indent using spaces, not tabs
 indent-tabs-mode nil
 ;; tab width
 tab-width 2)

;; disable cursor blinking
(blink-cursor-mode -1)

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
               ("shell" (or
			 (mode . eshell-mode)
			 (mode . term-mode)))
               ("mu4e" (or
                         (mode . mu4e-compose-mode)
                         (name . "\*mu4e\*")))
               ("programming" (or
                               (mode . python-mode)
                               (mode . sh-mode)
                               (mode . web-mode)
                               (mode . emacs-lisp-mode)
                               (mode . lisp-mode)
                               (mode . dart-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))))))

;; activiate the above ibuffer configuration
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; ibuffer options
(setq
 ;; Don't show filter groups if there are no buffers in that group
 ibuffer-show-empty-filter-groups nil
 ;; Don't ask for confirmation to delete marked buffers
 ibuffer-expert t)

;; delete trailing whitespaces on save
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;;; set default column width
(setq-default fill-column 80)

;;; hide tool bar, menu bar and scroll bar
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; auto-fill mode
(add-hook 'mail-mode-hook 'auto-fill-mode)
(add-hook 'mail-mode-hook (lambda () (setq fill-column 72)))

;; set default web browser
(setq browse-url-generic-program
      (substring (shell-command-to-string "gconftool-2 -g /desktop/gnome/url-handlers/https/command") 0 -4)
      browse-url-browser-function 'browse-url-generic)

;; set font
(set-frame-font "Fira Code 8" nil t)

;; set the default font after the frame is created.
;; needed because of some issue with emacsclient.
(add-hook 'after-make-frame-functions
	  (lambda (frame) (set-frame-font "Fira Code 8" nil t)))

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

;; Open link under cursor
(global-set-key (kbd "C-x e") 'mu4e-in-new-frame)

;; eval region
(global-set-key (kbd "C-c x") 'eval-region)

;; revert buffer (reload file from disk)
(global-set-key (kbd "<f5>" ) 'revert-buffer)

;; use ibuffer as default
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; toggle auto-fill-mode
(global-set-key (kbd "C-c q") 'auto-fill-mode)

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

;; -----------------------------------------------------------------------------

;; Packages and package configuration
;;
;; all packages should be loaded with use-package

;; server
(use-package server
  :if window-system
  :hook
  ((after-init-hook . server-start)
   ;; StumpWM interaction
   (server-done-hook . (lambda ()
			 (shell-command
			  "stumpish 'eval (stumpwm::return-es-called-win stumpwm::*es-win*)'"))))
  :init (setq server-raise-frame t))

;; diminish
;; Diminished modes are minor modes with no modeline display
(use-package diminish
  :init
  (diminish 'abbrev-mode))

;; which-key
;; Display available keybindings in popup
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;; org-bullets
;; Show bullets in org-mode as UTF-8 characters
(use-package org-bullets
  :hook
  (org-mode-hook . (lambda () (org-bullets-mode 1))))

;; undo-tree
;; Treat undo history as a tree
(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode))

;; beacon
;; Highlight the cursor whenever the window scrolls
(use-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode))

;; expand-region
;; Increase selected region by semantic units.
(use-package expand-region
  :bind (("C-=" . er/expand-region)))

;; dired+
;; Extensions to Dired
(use-package dired+)

;; projectile
;; Manage and navigate projects in Emacs easily
(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))


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
  :diminish pcre-mode
  :config
  (pcre-mode t))

;; visual-regexp
;; A regexp/replace command for Emacs with interactive visual feedback
(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)
   ("C-c m" . vr/mc-mark)))

;; mu4e-alert
;; Desktop notification for mu4e
(use-package mu4e-alert
  :after (mu4e)
  :config
  (mu4e-alert-set-default-style 'libnotify)
  :hook
  ((after-init-hook . mu4e-alert-enable-notifications)
   (after-init-hook . mu4e-alert-enable-mode-line-display)))

;; indent-guide
;; show vertical lines to guide indentation
(use-package indent-guide
  :diminish indent-guide-mode
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
  :mode "\\.org$"
  :config
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


  ;; latex related option (mainly support for lualatex)
  (setq
   ;; add latex packages and configurations
   org-latex-packages-alist
   '(
     ("" "booktabs" t)
     ("" "listings" t)
     ("" "xcolor" t)
     ("" "polyglossia" t)
     ("utf8" "luainputenc" t)
     ("" "fontspec" t)
     ("hidelinks" "hyperref" t)
     ("scale=0.9" "AnonymousPro" t)
     "\\setmainfont{Linux Libertine O}"
     "\\setsansfont{Linux Biolinum O}"
     "\\setmonofont{AnonymousPro}"
     "\\setdefaultlanguage{german}")
   ;; enable latex listings
   org-latex-listings 'listings
   ;; latex listings options
   org-latex-listings-options
   '(
     ("frame" "single")
     ("rulesep" "6pt")
     ("backgroundcolor" "\\color{gray!20}")
     ("basicstyle" "\\footnotesize\\ttfamily")
     ("breaklines" "true")))

  ;; remove unused default packages
  (unless (boundp 'org-latex-default-packages-alist)
    (setq org-latex-default-packages-alist nil))
  (setq
   org-latex-default-packages-alist (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist)
   org-latex-default-packages-alist (remove '("" "fixltx2e" nil) org-latex-default-packages-alist)
   org-latex-default-packages-alist (remove '("" "hyperref" nil) org-latex-default-packages-alist)
   org-latex-default-packages-alist (remove '"\\tolerance=1000" org-latex-default-packages-alist))

  ;; syntax highlighting
  (setq org-src-fontify-natively t)

  ;; set default agenda file
  (setq org-agenda-files (quote ("/home/marcel/cloud/todo.org")))

  ;; set priority range from A to C with A being the highest
  (setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
			     (?B . (:foreground "LightSteelBlue"))
			     (?C . (:foreground "OliveDrab"))))

  ;; open agenda in current window
  (setq org-agenda-window-setup (quote current-window))

  ;; bind capture templates
  (define-key global-map (kbd "C-c c") 'org-capture)
  (setq org-capture-templates
	'(("t" "todo" entry (file+headline "/home/marcel/cloud/todo.org" "Tasks")
	   "* TODO [#A] %?")
	  ("s" "scheduled todo" entry (file+headline "/home/marcel/cloud/todo.org" "Tasks")
	   "* TODO [#A] %? \nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
	  ("m" "scheduled mail" entry (file+headline "/home/marcel/cloud/todo.org" "Tasks")
	   "* TODO [#A] %? \nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

  ;; warn of deadlines in the next seven days
  (setq org-deadline-warning-days 7)

  ;; show tasks in the next 14 days
  (setq org-agenda-span (quote fortnight))

  ;; don't show tasks as scheduled if they are already shown as a deadline
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)

  ;; don't give awarning colour to tasks with impending deadlines
  ;; if they are scheduled to be done
  (setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))

  ;; don't show tasks that are scheduled or have deadlines in the normal todo list
  (setq org-agenda-todo-ignore-deadlines (quote all))
  (setq org-agenda-todo-ignore-scheduled (quote all))

  ;; sort tasks in order of when they are due and then by priority
  (setq org-agenda-sorting-strategy
	(quote
	 ((agenda deadline-up priority-down)
	  (todo priority-down category-keep)
	  (tags priority-down category-keep)
	  (search category-keep))))

  ;; mu4e connection
  (require 'org-mu4e)

  ;; store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil)

  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)))

;; fill-column-indicator
;; Graphically indicate the fill column
(use-package fill-column-indicator
  :config
  (setq
   ;; set rule width to 5px
   fci-rule-width 5
   ;; set rule color
   fci-rule-color "#5B6268"))

;; diff-hl
;; Highlight uncommitted changes using VC
(use-package diff-hl
  :defer nil
  :config (global-diff-hl-mode t)
  :hook (magit-post-refresh-hook . diff-hl-magit-post-refresh))

;; treemacs
;; A tree style file explorer package
(use-package treemacs
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
  :after treemacs
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

;; rainbow-delimiters
;; Highlight brackets according to their depth
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; pdf-tools
;; Support library for PDF documents.
(use-package pdf-tools
  :config
  (pdf-tools-install))

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
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-display-style 'fancy
        ivy-extra-directories nil)
  :bind
  (("C-c C-r" . ivy-resume)))

;; swiper
;; Isearch with an overview. Oh, man!
(use-package swiper
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-display-style 'fancy
        ivy-extra-directories nil)
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   :map read-expression-map
   ("C-r" . counsel-expression-history)))

;; counsel-projectile
;; Ivy UI for Projectile
(use-package counsel-projectile
  :after (projectile)
  :config
  (counsel-projectile-mode))

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
  :mode ("\\.org$" . org-mode)
  :config
  ;; use lualatex instead of pdflatex
  (setq org-pandoc-options-for-latex-pdf '((latex-engine . "lualatex"))
        org-pandoc-options-for-beamer-pdf '((latex-engine . "lualatex"))))

;; org-trello
;; Minor mode to synchronize org-mode buffer and trello board
(use-package org-trello
  :mode ("\\.org$" . org-mode))

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
  :diminish company-mode
  :init
  (global-company-mode t)
  :config
  (setq company-show-numbers t))

;; company-math
;; Completion backends for unicode math symbols and latex tags
(use-package company-math
  :after (company tex)
  :hook (TeX-mode-hook . (lambda ()
			   (setq-local company-backends
				       (append '((company-math-symbols-latex company-latex-commands))
					       company-backends)))))

(use-package company-shell
  :after (company shell-mode))

;; beginend
;; Redefine M-< and M-> for some modes
(use-package beginend
  :diminish (beginend-global-mode
	     beginend-prog-mode
	     beginend-magit-status-mode)
  :config
  (beginend-global-mode t))

;; markdown-mode
;; Major mode for Markdown-formatted text
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "kramdown"))

;; markdown-preview-mode
;; markdown realtime preview minor mode
(use-package markdown-preview-mode
  :after (markdown-mode)
  :config
  (add-to-list 'markdown-preview-javascript "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"))

;; web-mode
;; major mode for editing web templates
(use-package web-mode
  :mode
  (("\\.phtml\\'" . web-mode))
  (("\\.tpl\\.php\\'" . web-mode))
  (("\\.[agj]sp\\'" . web-mode))
  (("\\.erb\\'" . web-mode))
  (("\\.mustache\\'" . web-mode))
  (("\\.djhtml\\'" . web-mode))
  (("\\.html?\\'" . web-mode))
  (("\\.css?\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-enable-css-colorization t
        web-mode-code-indent-offset 2
        web-mode-indent-style 2))

;; js2-mode
;; Major mode for editing JavaScript files
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)))

;; dart-mode
;; Major mode for editing Dart files
(use-package dart-mode
  :mode (("\\.dart\\'" . dart-mode)))

;; csv-mode
;; Major mode for editing comma/char separated values
(use-package csv-mode
  :mode (("\\.csv\\'" . csv-mode))
  :config (setq csv-separators '(";")))

;; json-mode
;; Major mode for editing JSON files
(use-package json-mode
  :mode (("\\.json\\'" . json-mode)))

;; focus
;; Dim the font color of text in surrounding sections
(use-package focus
  :defer t)

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
(use-package php-mode
  :mode (("\\.php\\'" . php-mode)))

;; fish-mode
;; Major mode for fish shell scripts
(use-package fish-mode
  :mode (("\\.fish\\'" . fish-mode)))

;; easy-hugo
;; Write blogs made with hugo by markdown or org-mode
(use-package easy-hugo
  :defer t)

;; stumpwm-mode
;; special lisp mode for evaluating code into running stumpwm
(use-package stumpwm-mode
  :mode (("stumpwmrc" . stumpwm-mode)))

;; slime
;; Superior Lisp Interaction Mode for Emacs
(use-package slime
  :mode (("\\.lisp\\'" . slime)
	 ("stumpwmrc" . slime))
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;; slime-company
;; slime completion backend for company mode
(use-package slime-company
  :after (slime company)
  :config
  (setq slime-contribs '(slime-fancy slime-company)))

;; yaml-mode
;; Major mode for editing YAML files
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; sass-mode
;; Major mode for editing Sass files
(use-package sass-mode
  :mode (("\\.scss\\'" . scss-mode)
	 ("\\.sass\\'" . sass-mode)))

;; coffee-mode
;; Major mode for CoffeeScript code
(use-package coffee-mode
  :mode (("\\.coffee\\'" . coffee-mode))
  :config (setq whitespace-action '(auto-cleanup)
		whitespace-style '(trailing space-before-tab indentation empty space-after-tab)
		coffee-tab-width 2)
  :hook (coffee-mode-hook whitespace-mode))

;; python
;; Python's flying circus support for Emacs
(use-package python
  :mode (("\\.py\\'" . python-mode))
  :config (setq flycheck-python-pylint-executable "pylint3"))

;; sr-speedbar
;; Same frame speedbar
(use-package sr-speedbar
  :bind (("s-b" . sr-speedbar-toggle)))

;; moinmoin
;; Major mode for editing MoinMoin wiki entries
(use-package moinmoin
  :load-path "moinmoin/"
  :mode (("\\.wiki\\'" . moinmoin-mode)))

;; mu4e
;; emacs mail client
(use-package mu4e
  :load-path "/usr/share/emacs/25.1/site-lisp/mu4e/"
  :commands mu4e
  :config
  ;; get mail
  (setq
   mu4e-get-mail-command "offlineimap"
   mu4e-update-interval 300)

  ;; faster reindexing
  (setq mu4e-maildir-index-cleanup nil
        mu4e-index-lazy-check t)

  ;; smtpmail settings
  (setq  message-send-mail-function 'smtpmail-send-it
         send-mail-function 'smtpmail-send-it)

  ;; general mu4e options
  (setq
   ;; use mu4e as default emacs mailer
   mail-user-agent 'mu4e-user-agent
   ;; don't keep message buffers around
   message-kill-buffer-on-exit t
   ;; don't save sent messages to "Sent" folder
   mu4e-sent-messages-behavior 'delete
   ;; complete date format
   mu4e-headers-date-format "%Y-%m-%d %H:%M"
   ;; show full addresses
   mu4e-view-show-addresses 't
   ;; attachment directory
   mu4e-attachment-dir  "/tmp"
   ;; don't reply to myself
   mu4e-compose-dont-reply-to-self t
   ;; maildir
   mu4e-maildir "~/.mail"
   ;; use correct account context when sending mail based from headers
   message-sendmail-envelope-from 'header)

  ;; list of email addresses
  (setq mu4e-user-mail-address-list
        '("marcel.kapfer@uni-ulm.de"
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
  (setq mu4e-headers-fields
        '((:human-date . 20)
          (:flags . 6)
          (:mailing-list . 15)
          (:from-or-to . 22)
          (:subject . nil)))

  ;; convenience function for starting the whole mu4e in its own frame
  ;; posted by the author of mu4e on the mailing list
  (defun mu4e-in-new-frame ()
    "Start mu4e in new frame."
    (interactive)
    (select-frame (make-frame))
    (mu4e))

  ;; set citation line
  (setq message-citation-line-format "%f @ %Y-%m-%d %H:%M:%S %Z:\n")
  (setq message-citation-line-function 'message-insert-formatted-citation-line)

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
		:name "Important Unread Messages"
		:query "(m:/university* OR m:/mailbox/inbox) AND flag:unread AND NOT  flag:trashed"
		:key ?i))
  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Open Messages"
		:query "(flag:unread AND NOT flag:trashed ANT NOT m:/mailbox/debian/devel-changes AND NOT m:/university/fin/service/open) OR m:/mailbox/inbox OR m:/university/inbox"
		:key ?u))
  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Flagged messages"
		:query "flag:flagged AND NOT flag:trashed"
		:key ?f))

  ;; custom shortcuts
  (setq mu4e-maildir-shortcuts
	'(("/university/inbox" . ?u)
	  ("/university/fin/fin" . ?f)
	  ("/university/fin/intern" . ?i)
	  ("/mailbox/inbox" . ?m)
	  ("/mailbox/debian/devel-changes" . ?c)
	  ("/mailbox/debian/user" . ?d)))

  ;; enable spell checking
  (add-hook 'mu4e-compose-mode-hook #'flyspell-mode)
  ;; always BCC myself
  (add-hook 'mu4e-compose-mode-hook (lambda () (save-excursion (message-add-header (concat "Bcc: " user-mail-address "\n")))))
  ;; sign message
  (add-hook 'mu4e-compose-mode-hook (lambda () (mml-secure-message-sign-pgpmime))))

;; elfeed
;; emacs feed reader
(use-package elfeed
  :bind
  (("C-x w" . elfeed))
  :config
  (defun elfeed-search-format-date (date)
    (format-time-string "%Y-%m-%d %H:%M" (seconds-to-time date))))

;; elfeed-org
;; use an org-file to organize feeds
(use-package elfeed-org
  :after (elfeed)
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/ownCloud/feeds.org")))

;; bug-hunter
;; Hunt down errors by bisecting elisp files
(use-package bug-hunter
  :defer t)

;; hl-todo
;; highlight TODOs and similar keywords
(use-package hl-todo
  :init (global-hl-todo-mode))

;; yasnippets
;; Yet another snippet extension for Emacs.
(use-package yasnippet)

;; company-quickhelp
;; Documentation popup for Company
(use-package company-quickhelp
  :after (company)
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
  :config
  (setq
   ;; Parse file after loading it if no style hook is found for it.
   TeX-parse-self t
   ;; Automatically save style information when saving the buffer.
   TeX-auto-save t
   ;; Automatically interst braces after sub- and superscript in math mode
   ;; TeX-electric-sub-and-superscript t
   ;; Don't ask the user when saving a file for each file.
   TeX-save-query nil
   ;; enable synctex correlation.
   TeX-source-correlate-mode t
   TeX-source-correlate-start-server t
   ;; use pdf-tools with synctex
   TeX-view-program-selection '((output-pdf "PDF Tools"))
   TeX-source-correlate-start-server t)

  (setq-default
   ;; set to nil, so AUCTeX always asks for the master file
   TeX-master nil
   ;; use a decent, modern TeX engine
   TeX-engine 'luatex))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-buf
  :ensure auctex
  ;; Don't ask for confirmation when saving before processing
  :config (setq TeX-save-query nil))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-style
  :ensure auctex
  :config
  ;; Enable support for csquotes
  (setq LaTeX-csquotes-close-quote "}"
        LaTeX-csquotes-open-quote "\\enquote{"))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-fold
  :ensure auctex
  :init (add-hook 'TeX-mode-hook #'TeX-fold-mode))

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package tex-mode
  :ensure auctex)

;; LaTeX with AUCTeX
;; Integrated environment for TeX
(use-package latex
  :ensure auctex
  :defer nil
  :config
  ;; No language-specific hyphens please
  (setq LaTeX-babel-hyphen nil)

  ;; helper for a new (La)TeX style guide concept.
  ;; inserts a line break, a empty comment line and another line break
  (defun TeX-insert-comment-line ()
    "Insert a linebreak followed by a '%' and another line break"
    (interactive)
    (newline-and-indent)
    (insert "%")
    (newline-and-indent))
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
  (add-hook 'TeX-mode-hook #'auto-fill-mode)

  :bind (:map latex-mode-map
	      ("<C-return>" . TeX-insert-comment-line)))

;; bibtex
;; BibTeX editing
(use-package bibtex
  ;; Use a modern BibTeX dialect
  :config (bibtex-set-dialect 'biblatex)
  ;; Run prog mode hooks for bibtex
  :hook (bibtex-mode-hook . (lambda () (run-hooks 'prog-mode-hook))))

;; reftex
;; TeX cross-reference management
(use-package reftex
  :diminish reftex-mode
  :config
  (setq
   ;; Plug into AUCTeX
   reftex-plug-into-AUCTeX t
   ;; Automatically derive labels, and prompt for confirmation
   reftex-insert-label-flags '(t t))
  :hook (LaTeX-mode-hook . reftex-mode))

;; term / ansi-term
;; terminal in emacs
(use-package term
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
  :hook (term-mode-hook . (lambda () (nlinum-mode -1)))

  :bind (("C-c s" . ansi-term)
	 :map term-raw-map
	 ("C-y" . term-paste)))

;; saveplace
;; save the last cursor position in a file
(use-package saveplace
  :init (save-place-mode t))

;; tramp
;; do stuff over ssh at al.
(use-package tramp
  :init
  ;; Set default connection method for TRAMP
  (setq tramp-default-method "ssh"))

;; telephone-line
;; A new implementation of Powerline for Emacs
(use-package telephone-line
  :init
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
	telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
	telephone-line-primary-right-separator 'telephone-line-cubed-right
	telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
  (telephone-line-mode 1))
