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

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

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
      auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t))
      ;; version numbers for backup files
      version-control t
      ;; delete excess backup versions
      delete-old-versions t
      ;; amount of new versions to keep
      kept-new-versions 20
      ;; amount of old versions to keep
      kept-old-versions 5)

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
 ;; always follow symlinks to git repos
 vc-follow-symlinks t
 ;; indent using spaces, not tabs
 indent-tabs-mode nil
 ;; tab width
 tab-width 2
 ;; https://www.reddit.com/r/emacs/comments/819v0h/how_to_speed_up_cursor_movement_by_10x/
 auto-window-vscroll nil
 ;; Tell imenu to rescan tags
 imenu-auto-rescan t)

;; set timezone
(setenv "TZ" "/etc/localtime")

;; disable cursor blinking
(blink-cursor-mode -1)

;; activate winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Highlight the current line
(global-hl-line-mode t)

;; replace selected text by typing
(delete-selection-mode t)

;; break lines better
(visual-line-mode t)

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

;; set default column width
(setq-default fill-column 80)

;; set cursor style to a vertical bar
(setq-default cursor-type 'bar)

;; hide tool bar, menu bar and scroll bar
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; auto-fill mode
(add-hook 'mail-mode-hook 'auto-fill-mode)
(add-hook 'mail-mode-hook (lambda () (setq fill-column 72)))

;; set default web browser
(setq browse-url-generic-program "x-www-browser")

;; set font
(set-frame-font "Hermit 8" nil t)

;; set the default font after the frame is created.
;; needed because of some issue with emacsclient.
(add-hook 'after-make-frame-functions
	  (lambda (frame) (set-frame-font "Hermit 8" nil t)))

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

;; curx
;; A Collection of Ridiculously Useful eXtensions for Emacs
(use-package crux
  :bind
  (("C-a" . crux-move-beginning-of-line)))

;; which-key
;; Display available keybindings in popup
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;; org-bullets
;; Show bullets in org-mode as UTF-8 characters
(use-package org-bullets
  :after org
  :config (add-hook 'org-mode-hook #'org-bullets-mode))

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
(use-package dired+
  :load-path "dired+/")

;; projectile
;; Manage and navigate projects in Emacs easily
(use-package projectile
  :diminish projectile-mode
  :defer t
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
(use-package origami
  :defer t)

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

;; highlight-indent-guides
;; show vertical lines to guide indentation
(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :config
  (setq highlight-indent-guides-method 'character)
  :hook
  (prog-mode . highlight-indent-guides-mode))

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
   ;; scrartcl as default class
   org-latex-default-class "scrartcl"
   ;; lualatex as default compiler
   org-latex-compiler "lualatex"
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
     "\\setmainfont{Linux Libertine O}"
     "\\setsansfont{Linux Biolinum O}"
     "\\setmonofont[Scale=0.9]{AnonymousPro}"
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

  ;; add comment to easy templates
  ;; Credits: http://acidwords.com/posts/2018-03-02-extending-org-mode-easy-templates.html
  (add-to-list 'org-structure-template-alist
	       '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))

  ;; org todo keywords
  ;; Creadits: https://changelog.complete.org/archives/9877-emacs-3-more-on-org-mode
  (setq org-todo-keywords '((sequence
			     "TODO(t!)" "NEXT(n!)" "STARTED(a!)" "WAIT(w@/!)" "OTHERS(o!)"
			     "|" "DONE(d)" "CANCELLED(c)")))

  (setq
   ;; syntax highlighting
   org-src-fontify-natively t
   ;; Don't break line on M-RET
   org-M-RET-may-split-line nil
   ;; Log done time
   org-log-done 'time
   ;; only show last star
   org-hide-leading-stars t
   ;; show something instead of ...
   org-ellipsis "⤵")

  ;; set default agenda file
  (setq org-agenda-files (list "~/cloud/org/todo.org"
			       "~/cloud/org/notes.org"
			       "~/cloud/org/projects.org")
	org-agenda-text-search-extra-files (list "~/cloud/org/finance.org"
						 "~/cloud/org/emacs-magic.org"
						 "~/cloud/org/wiki.org"))

  ;; set priority range from A to C with A being the highest
  (setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
			     (?B . (:foreground "LightSteelBlue"))
			     (?C . (:foreground "OliveDrab"))))

  ;; open agenda in current window
  (setq org-agenda-window-setup (quote current-window))

  ;; bind capture templates
  (setq org-capture-templates
	'(("t" "todo" entry (file+headline "~/cloud/org/todo.org" "Tasks")
	   "* TODO [#A] %? %^G\n  %u")
	  ("s" "scheduled todo" entry (file+headline "~/cloud/org/todo.org" "Tasks")
	   "* TODO [#A] %? %^G\n  SCHEDULED: %^T\n  %u\n")
	  ("m" "scheduled mail" entry (file+headline "~/cloud/org/todo.org" "Tasks")
	   "* TODO [#A] %? %^G\n  SCHEDULED: %^T\n  %u\n  %a\n")
	  ("n" "Note" entry (file+headline "~/cloud/org/notes.org" "Notes")
	   "* %? \n  %i\n  %u\n  %a\n")
	  ("p" "Project Idea" entry (file+headline "~/cloud/org/projects.org" "INBOX")
	   "* %? %^G\n  %i\n  %u\n")
	  ("w" "Wiki Entry" entry (file+headline "~/cloud/org/wiki.org" "INBOX")
	   "* %? \n  %u\n  %i\n")))

  ;; set org refile targets
  (setq org-refile-targets '(("~/cloud/org/projects.org" :maxlevel 3)))

  ;; warn of deadlines in the next seven days
  (setq org-deadline-warning-days 7)

  ;; show tasks in the next 14 days
  (setq org-agenda-span (quote fortnight))

  ;; org sorthing strategy
  (setq org-agenda-sorting-strategy '(time-up priority-down))

  ;; don't show tasks as scheduled if they are already shown as a deadline
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)

  ;; don't give awarning colour to tasks with impending deadlines
  ;; if they are scheduled to be done
  (setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))

  ;; mu4e connection
  (require 'org-mu4e)

  ;; store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil)

  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)
   ("C-c o" . org-iswitchb)
   ("C-c a" . org-agenda))

  :hook (org-mode-hook . flyspell-mode))

;; org-super-agenda
;; Supercharge your Org daily/weekly agenda by grouping items
(use-package org-super-agenda
  :after org
  :init (org-super-agenda-mode 1)
  :config (setq org-super-agenda-groups
		'(
		  (:name "Today"
			 :time-grid t
			 :scheduled today)
		  (:name "Important from the past"
			 :and (:priority "A" :scheduled past))
		  (:name "Waiting..."
			 :todo "WAIT")
		  (:name "Scheduled earlier"
			 :scheduled past)
		  (:name "Not scheduled"
			 :scheduled nil)
		  (:priority<= "B"))))

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

;; winum
;; Navigate windows and frames using numbers
(use-package winum
  :config (winum-mode))

;; treemacs
;; A tree style file explorer package
(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (setq treemacs-is-never-other-window t
        treemacs-project-follow-cleanup t
        treemacs-python-executable (executable-find "python3")
        treemacs-recenter-after-file-follow t)
  (treemacs-follow-mode t)
  (treemacs-git-mode 'extended)
  (treemacs-filewatch-mode)
  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t 1" . treemacs-delete-other-window)
	("C-x t t" . treemacs)
	("C-x t B" . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

;; treemacs-projectile
;; Projectile integration for treemacs
(use-package treemacs-projectile
  :after treemacs projectile)

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
  :defer t
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
        ivy-extra-directories nil
	ivy-initial-inputs-alist nil)
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
  (("s-s" . avy-goto-char-2)
   ("s-l" . avy-goto-line)))

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

;; LESS style sheet support
(use-package less-css-mode
  :mode (("\\.less\\'" . less-css-mode)))

;; js2-mode
;; Major mode for editing JavaScript files
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)))

;; dart-mode
;; Major mode for editing Dart files
(use-package dart-mode
  :mode (("\\.dart\\'" . dart-mode)))

;; ruby
;; Support for the ruby language
(use-package enh-ruby-mode
  :after (robe inf-ruby)
  :mode (("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  :hook (('enh-ruby-mode-hook 'robe-mode)
	 ('enh-ruby-mode-hook 'inf-ruby-minor-mode)))

(use-package robe
  :after (company-mode)
  :config (push 'company-robe company-backends))

(use-package inf-ruby
  :defer t)

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

;; moinmoin
;; Major mode for editing MoinMoin wiki entries
(use-package moinmoin
  :load-path "moinmoin/"
  :mode (("\\.wiki\\'" . moinmoin-mode)))

;; typoscript-mode
;; A mode for TYPO3 typoscript
(use-package typoscript-mode
  :mode (("\\.typoscript\\'" . typoscript-mode)))

;; mu4e
;; emacs mail client
(use-package mu4e
  :load-path "/usr/share/emacs/25.1/site-lisp/mu4e/"
  :commands mu4e
  :config
  ;; get mail
  (setq
   mu4e-get-mail-command "mbsync -a"
   mu4e-update-interval 300
   mu4e-change-filenames-when-moving t)

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
   mu4e-maildir "~/.mbsync"
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

  ;; custom header field for maildir
  (add-to-list 'mu4e-header-info-custom
	       '(:mdir . (:name "Maildir"
				:shortname "Maildir"
				:help "Maildir of current message"
				:function (lambda (msg)
					    (or
					     (replace-regexp-in-string
					      "^/\\(.\\)[A-Za-z0-9]*"
					      "\\1"
					      (mu4e-message-field msg :maildir))
					     "")))))

  ;; customize mu4e list view
  (setq mu4e-headers-fields
        '((:human-date . 20)
          (:flags . 6)
	  (:mdir . 15)
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
  (setq message-citation-line-format "%f @ %Y-%m-%d %T %Z:\n")
  (setq message-citation-line-function
	(lambda ()
	  (message-insert-formatted-citation-line
	   nil nil (car (current-time-zone)))))

  ;; macro for creating university mu4e contexts
  (defmacro mu4e-add-university-context (context-name match-func mail-address full-name signature-file)
    "Add a university context to `mu4e-contexts.
context-name is the name of the context.
match-func a function when the context should be selected.
full-name is the full name of the sender.
mail-address is the mail address of the sender.
signature-file is the path to the file which contains the signature."
    `(add-to-list
      'mu4e-contexts
      (make-mu4e-context
       :name ,context-name
       :enter-func (lambda () (mu4e-message ,(concat context-name " Context")))
       :match-func ,match-func
       :vars '((user-mail-address . ,mail-address)
	       (user-full-name . ,full-name)
	       (message-signature-file . ,signature-file)
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
      t))

  ;; mu4e contexts / mail identities
  (setq mu4e-contexts
	`( ,(make-mu4e-context
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

  ;; university contexts
  (mu4e-add-university-context
   "A University"
   nil
   "marcel.kapfer@uni-ulm.de"
   "Marcel Kapfer"
   nil)

  (mu4e-add-university-context
   "B StuVe Oeff-Ref"
   nil
   "stuve.oeffentlichkeit@uni-ulm.de"
   "StuVe Öffentlichkeitsreferat"
   "~/dotfiles/dotdotfiles/sig/stuve-oeffentlichkeit")

  (mu4e-add-university-context
   "C BECI-Fest"
   nil
   "becifest.kontakt@uni-ulm.de"
   "BECI-Fest"
   "~/dotfiles/dotdotfiles/sig/becifest")

  (mu4e-add-university-context
   "D SoNaFe"
   nil
   "kontakt@sonafe.de"
   "Sommernachtsfest (SoNaFe)"
   "~/dotfiles/dotdotfiles/sig/sonafe-kontakt")

  (mu4e-add-university-context
   "E FIN Vorstand"
   nil
   "vorstand.fin@uni-ulm.de"
   "FIN Vorstand"
   "~/dotfiles/dotdotfiles/sig/fin-vorstand")

  (mu4e-add-university-context
   "F FIN Oeff-Team"
   nil
   "oeffentlichkeit.fin@uni-ulm.de"
   "FIN Öffentlichkeits-Team"
   "~/dotfiles/dotdotfiles/sig/fin-oeffentlichkeit")

  ;; custom bookmarks
  (setq mu4e-bookmarks (delete '("flag:unread AND NOT flag:trashed" "Unread messages" 117) mu4e-bookmarks))

  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Open Messages"
		:query "(flag:unread AND NOT flag:trashed AND NOT m:/university/fin/service/open) OR m:/university/inbox OR m:/mailbox/inbox OR m:/university/oeffref/inbox"
		:key ?o))
  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Open University Messages"
		:query "(flag:unread AND NOT flag:trashed AND m:/university/* AND NOT m:/university/fin/service/open) OR m:/university/inbox OR m:/university/oeffref/inbox"
		:key ?u))
  (add-to-list 'mu4e-bookmarks
	       (make-mu4e-bookmark
		:name "Open Private Messages"
		:query "(flag:unread AND NOT flag:trashed AND m:/mailbox/*) OR m:/mailbox/inbox"
		:key ?m))
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
	  ("/university/fin/service/open" . ?s)
	  ("/mailbox/inbox" . ?m)
	  ("/mailbox/debian/devel-changes" . ?c)
	  ("/mailbox/debian/user" . ?d)))

  ;; enable spell checking
  (add-hook 'mu4e-compose-mode-hook #'flyspell-mode)
  ;; always BCC myself
  (add-hook 'mu4e-compose-mode-hook (lambda () (save-excursion (message-add-header (concat "Bcc: " user-mail-address "\n")))))
  ;; sign message
  ;; (add-hook 'mu4e-compose-mode-hook (lambda () (mml-secure-message-sign-pgpmime))))
  )

;; elfeed
;; emacs feed reader
(use-package elfeed
  :defer t
  :config
  (defun elfeed-search-format-date (date)
    (format-time-string "%Y-%m-%d %H:%M" (seconds-to-time date))))

;; elfeed-protocol
;; use Nextcloud as RSS server
(use-package elfeed-protocol
  :after (elfeed)
  :config
  (setq elfeed-use-curl t)
  (elfeed-set-timeout 36000)
  (setq elfeed-feeds (list
		      (list "owncloud+https://mmk2410@cloud.mmk2410.org"
			    :password (funcall
				       (plist-get
					(nth 0
					     (auth-source-search
					      :host "cloud.mmk2410.org"
					      :user "mmk2410"
					      :require '(:secret)))
					:secret)))))
  (elfeed-protocol-enable))

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
  :after (latex)
  ;; Use a modern BibTeX dialect
  :config (bibtex-set-dialect 'biblatex)
  ;; Run prog mode hooks for bibtex
  :hook (bibtex-mode-hook . (lambda () (run-hooks 'prog-mode-hook))))

;; reftex
;; TeX cross-reference management
(use-package reftex
  :after (latex)
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

  (add-hook 'term-mode-hook (lambda ()
			      ;; disable nlinum in shell
			      (nlinum-mode -1)
			      ;; enable visual line mode
			      (visual-line-mode 1)))

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
  :defer t
  :init
  ;; Set default connection method for TRAMP
  (setq tramp-default-method "ssh")
  (require 'em-tramp)
  (setq password-cache-expiry 3600))

;; edit-server
(use-package edit-server
  :init (edit-server-start))

;; org-moinmoin
;; moinmoin export in org-mode
(use-package ox-moinmoin
  :after (org)
  :load-path "org-moinmoin/")

;; ox-reveal
;; Exports Org-mode contents to Reveal.js HTML presentation.
(use-package ox-reveal
  :after (org))

;; org-tree-slide
(use-package org-tree-slide
  :after (org)
  :bind (:map org-tree-slide-mode-map
	      ("<f9>" . org-tree-slide-move-previous-tree)
	      ("<f10>" . org-tree-slide-move-next-tree)
	      :map org-mode-map
	      ("<f8>" . org-tree-slide-mode)
	      ("S-<f8>" . org-tree-slide-skip-done-toggle)))

;; exec-path-from-shell
;; get environmet variables
(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  (exec-path-from-shell-copy-env "SSH_AGENT_PID"))

;; rust-mode
(use-package rust-mode
  :mode (("\\.rs\\'" . rust-mode)))

;; all-the-icons
;; A utility package to collect various Icon Fonts and propertized them within Emacs
(use-package all-the-icons)

;; spaceline
;; Powerline theme from Spacemacs
(use-package spaceline)

;; spaceline-all-the-icons
;; A Spaceline Mode Line theme using All The Icons
(use-package spaceline-all-the-icons
  :after spaceline
  :config (spaceline-all-the-icons-theme))

;; org-wiki
;; A personal wiki system for Emacs
;; Using the verison ofYouhei Sasaki which uses ido instead of helm
(use-package org-wiki
  :load-path "org-wiki/"
  :config
  (setq org-wiki-location "~/wiki"))
