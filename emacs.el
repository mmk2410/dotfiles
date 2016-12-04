
(setq user-full-name "Marcel Kapfer (mmk2410")
(setq user-mail-address "marcelmichaelkapfer@gmail.com")

(setq load-path (append (list (expand-file-name "/usr/local/lilypond/usr/share/emacs/site-lisp")) load-path))

(load "package")
(package-initialize)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(setq package-archive-enable-alist '(("melpa" deft magit)))

(setq tab-width 2)

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

;; Save backup files in .emacs
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t )))

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
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("1160f5fc215738551fce39a67b2bcf312ed07ef3568d15d53c87baa4fd1f4d4e" default)))
 '(send-mail-function (quote smtpmail-send-it))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (mediawiki ## edit-server muttrc-mode flymake-yaml flymake-vala flymake-shell flymake-sass flymake-rust flymake-ruby flymake-phpcs flymake-php flymake-lua flymake-jslint flymake-jshint flymake-css flymake-coffee dart-mode auto-complete-auctex auctex atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; edit-server

(require 'edit-server)
(edit-server-start)



; mmk2410 emacs configuration

;; variabels

;;; always follow symlinks to git repos
(setq vc-follow-symlinks t)

;;; set default column width
(setq-default fill-column 80)


;; packages

;;; fill-column indicator

(require 'fill-column-indicator)
(setq fci-rule-width 5) ;;; set rule width to 5px
(add-hook 'after-change-major-mode-hook 'fci-mode) ;; enable fci on every file
