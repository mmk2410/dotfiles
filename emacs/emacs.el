(setq user-full-name "Marcel Kapfer")
(setq user-mail-address "me@mmk2410.org")

(load "package")
(package-initialize)
(add-to-list 'package-archives
	     '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.milkbox.net/packages/"))
(setq package-archive-enable-alist '(("melpa" deft magit)))

(defalias 'yes-or-no-p 'y-or-n-p)

;; Org mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

;; Always show line numbers
(global-nlinum-mode t)

;; Highlight current line
(global-hl-line-mode t)

;; Autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)

;; Save backup files in temporary directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Mutt support.
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1B2229" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#DFDFDF"])
 '(csv-separators (quote (";")))
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "a4c9e536d86666d4494ef7f43c84807162d9bd29b0dfd39bdf2c3d845dcc7b2e" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "08b8807d23c290c840bbb14614a83878529359eaba1805618b3be7d61b0b0a32" "43bc55af3857f9e2dc14c4413739f36d758e4d75bcd9b67e9b7dc6d9fcc1db68" "6254372d3ffe543979f21c4a4179cd819b808e5dd0f1787e2a2a647f5759c1d1" "1160f5fc215738551fce39a67b2bcf312ed07ef3568d15d53c87baa4fd1f4d4e" default)))
 '(ecb-options-version "2.50")
 '(fci-rule-color "#5B6268")
 '(flycheck-python-pylint-executable "pylint3")
 '(inhibit-startup-screen t)
 '(jdee-global-classpath (quote ("/home/wilson/jdee-libs/")))
 '(jdee-server-dir "/opt/jdee-emacs-server/")
 '(org-agenda-files
   (quote
    ("~/Documents/uni/uulm-2017-2/priv/organisatorisches.org" "~/ownCloud/todo.org")))
 '(package-selected-packages
   (quote
    (avandu org company company-math counsel ivy beginend doom-themes neotree rainbow-delimiters projectile nlinum powerline airline-themes fic-mode markdown-preview-mode web-mode ob-dart ac-python ac-slime ant auctex-lua auto-compile auto-complete-auctex csv-mode csv ac-haskell-process ghc haskell-mode arduino-mode json-mode gruvbox-theme focus literate-coffee-mode jdee javadoc-lookup pkgbuild-mode vala-snippets vala-mode phpunit ac-php php-completion php+-mode fish-mode hugo mips-mode stumpwm-mode slime muttrc-mode diff-hl magit wanderlust ## auctex yaml-mode typescript sass-mode php-mode outlined-elisp-mode monokai-theme markdown-mode fill-column-indicator edit-server dracula-theme coffee-mode auto-complete atom-one-dark-theme atom-dark-theme)))
 '(safe-local-variable-values (quote ((TeX-engine . pdftex) (TeX-Engine . luatex))))
 '(send-mail-function (quote smtpmail-send-it))
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(web-mode-code-indent-offset 2)
 '(web-mode-indent-style 2))
 '(send-mail-function (quote smtpmail-send-it))
 '(tool-bar-mode nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#21242b" :foreground "#bbc2cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :family "Fira Code")))))


;; edit-server

(require 'edit-server)
(edit-server-start)



; mmk2410 emacs configuration

;; variabels

;;; always follow symlinks to git repos
(setq vc-follow-symlinks t)

;;; set default column width
(setq-default fill-column 80)

;;; settings for bells
(setq visible-bell 1)

;;; hide tool bar and menu bar
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;; delete selection mode
(delete-selection-mode 1)

;;; window / frame size
(setq initial-frame-alist
      '(
	(width . 102)
	(height . 44)
	))

(setq default-frame-alist
      '(
	(width . 100)
	(height . 42)
	))

;;; indention
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;;; slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; packages

;;; fill-column indicator

(require 'fill-column-indicator)
(setq fci-rule-width 5) ;;; set rule width to 5px

;;; diff-hl
(global-diff-hl-mode t)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; stumpwm: working with emacsclient
(add-hook 'after-init-hook 'server-start)
(setq server-raise-frame t)

(if window-system
    (add-hook 'server-done-hook
	      (lambda ()
		(shell-command
		 "stumpish 'eval (stumpwm::return-es-called-win stumpwm::*es-win*)'"))))

;; auto-fill-mode
(add-hook 'mail-mode-hook 'auto-fill-mode)
(add-hook 'mail-mode-hook (lambda () (setq fill-column 72)))
(global-set-key (kbd "C-c q") 'auto-fill-mode)

;; predictive mode
(add-to-list 'load-path "~/.emacs.d/pkg/predictive/")
(add-to-list 'load-path "~/.emacs.d/pkg/predictive/latex/")
(add-to-list 'load-path "~/.emacs.d/pkg/predictive/texinfo/")
(add-to-list 'load-path "~/.emacs.d/pkg/predictive/html/")
(add-to-list 'load-path "~/.emacs.d/pkg/predictive/misc/")
(autoload 'predictive-mode "predictive" "predictive" t)
(set-default 'predictive-auto-add-to-dict t)
(setq predictive-main-dict 'rpg-dictionary
      predictive-auto-learn t
      predictive-add-to-dict-ask nil
      predictive-use-auto-learn-cache nil
      predictive-which-dict t)

;; org mode

(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

;;; latex scrartcl as documentclass

(add-to-list 'org-latex-classes
             '("scrartcl"
               "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;; add latex packages and configurations
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

;;; enable latex listings
(setq org-latex-listings 'listings)

;;; latex listings options
(setq org-latex-listings-options
      '(
        ("frame" "single")
        ("rulesep" "6pt")
        ("backgroundcolor" "\\color{gray!20}")
        ("basicstyle" "\\footnotesize\\ttfamily")
        ("breaklines" "true")
        ))

;;; remove unused default packages
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

;;; syntax highlighting

(setq org-src-fontify-natively t)

;; neotree toggle
(global-set-key [f8] 'neotree-toggle)

;; magit status key
(global-set-key [f5] 'magit-status)

;; enable rainbow delimiters mode in programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; enable powerline modeline
(powerline-center-theme)


; ((Lua)La)TeX configuration using auctex

;; variables

;;; Automatically save style information when saving the buffer. 
(setq TeX-auto-save t)

;;; Parse file after loading it if no style hook is found for it. 
(setq TeX-parse-self t)

;;; Don't ask the user when saving a file for each file.
(setq TeX-save-query nil)

;;; Use luatex as default TeX engine.
(setq TeX-engine (quote luatex))

;;; Outline mode keyboard shortcut.
(setq outline-minor-mode-prefix "\C-c \C-o")

;;; set default master file to nil so auctex asks for it. 
(setq-default TeX-master nil)

;;; enable reftex auctex interaction.
(setq reftex-plug-into-auctex t)

;;; add the latex mode to the autocomplete modes.
(add-to-list 'ac-modes 'latex-mode)

;;; enable synctex correlation.
(setq TeX-source-correlate-mode t
      TeX-source-correlate-start-server t)

;; functions

;;; function for enabling outline mode
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

;;; autocompletion for latex
;;;; does this really work?
(defun ac-latex-mode-setup ()
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources)))

(eval-after-load "tex"
                 '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))

;; hooks

;;; hooks for outline mode
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)

;;; hook for fci-mode
(add-hook 'LaTeX-mode-hook 'fci-mode)

;;; hook for reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;;; hook for autocomplete.
(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)

;;; hook for auto fill mode
(add-hook 'TeX-mode-hook 'auto-fill-mode)

;;; hook for latex math mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;;; hook for rainbox delimiters mode
(add-hook 'TeX-mode-hook #'rainbow-delimiters-mode)

; themes

;; enable bold and italic
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

;;; enable doom one theme
(load-theme 'doom-one t)

;;; enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;;; enable neotree theme
(doom-themes-neotree-config)


;; experimental stuff

;;; ivy default configuration

(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
