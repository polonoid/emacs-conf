(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (jedi elpy cask-mode s cl-lib request nov cask novice+ company-irony-c-headers company ## magit lua-mode yasnippet iedit flymake-google-cpplint auto-complete-c-headers)))
 '(session-use-package t nil (session))
 '(tool-bar-mode nil))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")

(load "/opt/llvm/share/clang/clang-format.el")
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

(setq clang-format-style-option "Google")

(require 'git)
(require 'git-blame)

;; Magit status
(global-set-key (kbd "C-x g") 'magit-status)

(set-frame-parameter nil 'background-mode 'light)
(load-theme 'solarized t)
(setq column-number-mode t)

;; optional, must have rtags installed
(require 'rtags)
(require 'cmake-ide)
(cmake-ide-setup)

;;cmake-ide-flags-c++
(setq cmake-ide-flags-c++;;ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
 	      (split-string
"/opt/gcc-7.4.0/lib/gcc/x86_64-unknown-linux/7.4.0/../../../../include/c++/7.4.0
 /opt/gcc-7.4.0/lib/gcc/x86_64-unknown-linux/7.4.0/../../../../include/c++/7.4.0/x86_64-unknown-linux
 /opt/gcc-7.4.0/lib/gcc/x86_64-unknown-linux/7.4.0/../../../../include/c++/7.4.0/backward
 /opt/gcc-7.4.0/lib/gcc/x86_64-unknown-linux/7.4.0/include
 /usr/local/include
 /opt/gcc-7.4.0/include
 /opt/gcc-7.4.0/lib/gcc/x86_64-unknown-linux/7.4.0/include-fixed
 /usr/include
 /usr/include/boost
 /opt/llvm/lib/clang/6.0.0/include"
	       )))


(require 'flycheck)
(global-flycheck-mode)


;; Enable lua-mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(require 'elpy)
;;(setq-default indent-tabs-mode nil)
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)

;; package.el with emacs
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
			 '("melpa" . "http://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/"))
(package-initialize)

			 
;; (require 'package)
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (proto (if no-ssl "http" "https")))
;;   ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
;;   (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
;;   ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
;;   (when (< emacs-major-version 24)
;;     ;; For important compatibility libraries like cl-lib
;;     (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))


;; initialize package.el
(package-initialize)
;;start auto-complete with emacs
(require 'auto-complete)
;; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
;; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '" /opt/gcc-7.4.0/include/c++/7.4.0")
  )


;; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)


;;(require 'auto-complete-clang)

;; (defun ac-cc-mode-setup ()
;;   (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
;;   (setq ac-sources '(ac-source-clang-async))
;;   (ac-clang-launch-completion-process)
;; )

;; (defun my-ac-config ()
;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))

;; (my-ac-config)

 ;; (defun my-ac-cc-mode-setup ()
 ;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
 ;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

 ;; (my-ac-cc-mode-setup)

;; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

(global-set-key (kbd "M-o") 'rtags-find-file)
(global-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
;;(global-set-key (kbd "M-,") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,")  (function rtags-find-references-at-point))



 (setq default-frame-alist
       '(;;(font ."-outline-Lucida Console-normal-r-normal-normal-13-112-96-96-c-*-iso8859-1" )
         ;;"-*-Lucida Console-normal-r-*-*-14-82-96-96-c-*-iso8859-1")
         ;;"-outline-Termius-normal-r-normal-normal-13-112-96-96-c-*-iso8859-1"
 	;;(background-color . "gray20")
		 ;;(background-color . "SlateGrey")
        ;; (foreground-color . "Wheat")
;; 	(foreground-color . "Black")
         ))

; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(require 'cmake-mode)

(setq cmake-ide-build-dir "/home/marselo/source/projectx/build/")

;; set current buffer's tab char's display width to 4 spaces
(setq tab-width 3) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(setq-default indent-tabs-mode t)
(setq-default tab-width 3)

(setq c-default-style "ellemtel" c-basic-offset 3)

(global-set-key (kbd "<f5>") 'cmake-ide-compile)


(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; remove toolbar
(tool-bar-mode -1)

;; ;;; Enable check-file only in Fortran mode buffers

;; (put 'check-file 'menu-enable '(eq major-mode 'fortran-mode))


;; ;;; Here are the new commands that are invoked by the "Compile" menu.

;; (defun previous-compilation-error ()
;;   "Visit previous compilation error message and corresponding source code.
;; See the documentation for the command `next-error' for more information."
;;   (interactive)
;;   (next-error -1))

;; (defun first-compilation-error ()
;;   "Visit the first compilation error message and corresponding source code.
;; See the documentation for the command `next-error' for more information."
;;   (interactive)
;;   (next-error '(4)))

;; (defvar check-history nil)

;; (defun check-file ()
;;   "Run ftnchek on the file contained in the current buffer"
;;   (interactive)
;;   (let* ((file-name (file-name-nondirectory buffer-file-name))
;; 		 (check-command (read-from-minibuffer
;; 						 "Check command: "
;; 						 (format "ftnchek %s" file-name) nil nil
;; 						 '(check-history . 1))))
;;     (save-some-buffers nil nil)
;;     (compile-internal check-command "Can't find next/previous error"
;; 					  "Checking" nil nil nil)))

;; (defun make ()
;;   "Run make in the directory of the file contained in the current buffer"
;;   (interactive)
;;   (save-some-buffers nil nil)
;;   (compile-internal (read-from-minibuffer "Make command: " "make ")
;; 					"Can't find next/previous error" "Make"
;; 					nil nil nil))


;; ;;; Define a function to be called by the compiled language mode hooks.

;; (defun add-compile-menu-to-mode ()
;;   "If the current major mode doesn't already have access to the \"Compile\"
;; menu, add it to the menu bar."
;;   (if (memq major-mode compile-menu-modes)
;;       nil
;;     (local-set-key [menu-bar compile] (cons "Compile" compile-menu))
;;     (setq compile-menu-modes (cons major-mode compile-menu-modes))
;;     ))


;; ;; And finally, make sure that the "Compile" menu is available in C, C++, and
;; ;; Fortran modes.
;; (add-hook 'c-mode-hook       (function add-compile-menu-to-mode))
;; (add-hook 'c++-c-mode-hook   (function add-compile-menu-to-mode))
;; (add-hook 'c++-mode-hook     (function add-compile-menu-to-mode))
;; (add-hook 'fortran-mode-hook (function add-compile-menu-to-mode))

;; ;; To make emacs use spaces instead of tabs (Added by Art Lee on 2/19/2008)
;; ;; (setq-default indent-tabs-mode nil)

;; ;; This is how emacs tells the file type by the file suffix.
;; (setq auto-mode-alist
;;       (append '(("\\.mss$" . scribe-mode))
;; 			  '(("\\.bib$" . bibtex-mode))
;; 			  '(("\\.tex$" . latex-mode))
;; 			  '(("\\.obj$" . lisp-mode))
;; 			  '(("\\.st$"  . smalltalk-mode))
;; 			  '(("\\.Z$"   . uncompress-while-visiting))
;; 			  '(("\\.cs$"  . indented-text-mode))
;; 			  '(("\\.C$"   . c-mode))
;; 			  '(("\\.cc$"  . c++-mode))
;; 			  '(("\\.icc$" . c++-mode))
;; 			  '(("\\.CPP$" . c++-mode))
;; 			  '(("\\.c$"   . c-mode))
;; 			  '(("\\.C$"   . c-mode))
;; 			  '(("\\.y$"   . c-mode))
;; 			  '(("\\.h$"   . c-mode))
;; 			  '(("\\.H$"   . c-mode))
;; 			  auto-mode-alist))

;; (setq ange-ftp-ftp-program-name "C:\\Ftp\\ftp.exe")


;;Gtags
;;(autoload 'gtags-mode "gtags" "" t)
;;(gtags-mode 1)
;;(global-set-key "\M-;" 'ww-next-gtag)   ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,

;;(global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag

;;(setenv "GTAGSLIBPATH" "/home/marselo/tbricks_gtags")

;; ;; if you want to enable support for gnu global
;; ;; (when (cedet-gnu-global-version-check t)

;; ;;   (require 'semanticdb-global)
;; ;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;; ;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;; (setq c-mode-hook
;; ;;       '(lambda ()
;; ;; 	 (gtags-mode 1)
;; ;; 	 ))

;; ;; (setq c++-mode-hook
;; ;;       '(lambda ()
;; ;; 	 (gtags-mode 1)
;; ;; 	 ))

;; (setq tramp-default-method "ftp")



;; (setenv "GS_LIB" "C:/Program Files/gs/gs9.05/lib")
;; (setq ps-lpr-command "C:/Program Files/gs/gs9.05/bin/gswin32c.exe")
;; (setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2"))
;; (setq ps-printer-name t)



;; (load-library "hideshow")
;; (global-set-key (kbd "C-+") 'toggle-hiding)
;; (global-set-key (kbd "C-\\") 'toggle-selective-display)
;; (add-hook 'c-mode-common-hook   'hs-minor-mode)
;; (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;; (add-hook 'java-mode-hook       'hs-minor-mode)
;; (add-hook 'lisp-mode-hook       'hs-minor-mode)
;; (add-hook 'perl-mode-hook       'hs-minor-mode)
;; (add-hook 'sh-mode-hook         'hs-minor-mode)


;; (autoload 'dos-mode "dos" "Edit Dos scripts." t)
;; (add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))

;; (require 'google-contacts)


;; ;;Set backup directory
;; (setq backup-directory-alist `(("." . "~/.saves")))

;; ;;Make backups by copying
;; (setq backup-by-copying t)


(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Lucida Console" :foundry "b&h" :slant normal :weight normal :height 113 :width semi-condensed)))))
(put 'dired-find-alternate-file 'disabled nil)
