(setq user-full-name "Marcel Kapfer")
(setq user-mail-address "marcelmichaelkapfer@gmail.com")

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
(global-linum-mode t)

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

;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

;; outline mode

(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

;; flymake for latex
(defun flymake-get-tex-args (file-name)
  (list "chktex" (list "-q" "-v0" file-name)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3c3836" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#d3869b" "#8ec07c" "#ebdbb2"])
 '(csv-separators (quote (";")))
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "08b8807d23c290c840bbb14614a83878529359eaba1805618b3be7d61b0b0a32" "43bc55af3857f9e2dc14c4413739f36d758e4d75bcd9b67e9b7dc6d9fcc1db68" "6254372d3ffe543979f21c4a4179cd819b808e5dd0f1787e2a2a647f5759c1d1" "1160f5fc215738551fce39a67b2bcf312ed07ef3568d15d53c87baa4fd1f4d4e" default)))
 '(ecb-options-version "2.50")
 '(fci-rule-color "#3E4451")
 '(inhibit-startup-screen t)
 '(jdee-global-classpath (quote ("/home/wilson/jdee-libs/")))
 '(jdee-server-dir "/opt/jdee-emacs-server/")
 '(org-agenda-files (quote ("~/ownCloud/todo.org")))
 '(package-selected-packages
   (quote
    (prolog web-mode fixme-mode ob-dart ac-python ac-slime ant auctex-lua auto-compile csv-mode csv ac-haskell-process ghc haskell-mode arduino-mode json-mode gruvbox-theme focus literate-coffee-mode jdee pkgbuild-mode vala-snippets vala-mode phpunit ac-php php-completion php+-mode fish-mode hugo mips-mode stumpwm-mode slime muttrc-mode diff-hl magit wanderlust ## auctex yaml-mode typescript sass-mode php-mode monokai-theme markdown-mode fill-column-indicator edit-server dracula-theme coffee-mode auto-complete atom-one-dark-theme atom-dark-theme)))
 '(safe-local-variable-values (quote ((TeX-Engine . luatex))))
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
 '(default ((t (:family "Hermit" :foundry "unknown" :slant normal :weight normal :height 90 :width normal)))))


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
(add-hook 'after-change-major-mode-hook 'fci-mode) ;; enable fci on every file

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

;; auctex
(setq-default TeX-master nil)

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)

;; ac-math
(add-to-list 'ac-modes 'latex-mode)

(defun ac-latex-mode-setup ()
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources)))

(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)

;; auto-fill-mode
(add-hook 'mail-mode-hook 'auto-fill-mode)
(add-hook 'TeX-mode-hook 'auto-fill-mode)
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

;;; syntax highlighting

(setq org-src-fontify-natively t)
