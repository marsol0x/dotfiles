; Global settings
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)
(setq scroll-step 3)
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks t)

(set-frame-font "-*-Liberation Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

; Emacs Window Things
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(toggle-frame-maximized)
(global-hl-line-mode 1)
(setq ring-bell-function 'ignore)

(when (display-graphic-p)
  (split-window-horizontally)
  (display-time)
  )

; Global Colors
(set-foreground-color "burlywood3")
(set-background-color "#161616")
(set-cursor-color "#40FF40")
(set-face-background 'hl-line "gray20")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
(set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
(set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")

(require 'cc-mode)
(require 'compile)
(require 'ido)
(require 'ag)
(ido-mode t)

; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp\\'"    . c++-mode)
	 ("\\.hin\\'"    . c++-mode)
	 ("\\.cin\\'"    . c++-mode)
	 ("\\.inl\\'"    . c++-mode)
	 ("\\.h\\'"      . c++-mode)
	 ("\\.c\\'"      . c++-mode)
	 ("\\.cc\\'"     . c++-mode)
	 ("\\.frag\\'"   . c++-mode)
	 ("\\.vert\\'"   . c++-mode)
	 ("\\.txt\\'"    . text-mode)
	 ("\\.?emacs\\'" . emacs-lisp-mode)
	 ("\\.md\\'"     . markdown-mode))
	 auto-mode-alist))

(setq ag-reuse-buffers 't)

(defun mjh-split-window-sensibly (&optional window)
  (if (= (length (window-list)) 1)
      (split-window window nil 'right nil)
    nil))
(setq split-window-preferred-function 'mjh-split-window-sensibly)

; TAB completes, shift-TAB actually tabs
(setq dabbrev-case-replace t)
(setq dabbrev-case-fold-search t)
(setq dabbrev-upcase-means-case-search t)

; Key mappings
(global-set-key (kbd "<C-right>") 'forward-word)
(global-set-key (kbd "<C-left>")  'backward-word)
(global-set-key (kbd "<C-down>")  'forward-paragraph)
(global-set-key (kbd "<C-up>")    'backward-paragraph)
(global-set-key (kbd "<home>")    'beginning-of-line)
(global-set-key (kbd "<end>")     'end-of-line)
(global-set-key (kbd "<C-home>")  'beginning-of-line)
(global-set-key (kbd "<C-end>")   'end-of-line)
(global-set-key (kbd "<pgup>")    'forward-page)
(global-set-key (kbd "<pgdown>")  'backward-page)
(global-set-key (kbd "<C-next>")  'end-of-buffer)
(global-set-key (kbd "<C-prior>") 'beginning-of-buffer)

(global-set-key (kbd "TAB")     'dabbrev-expand)
(global-set-key (kbd "<S-tab>") 'indent-for-tab-command)
(global-set-key (kbd "<C-tab>") 'indent-region)

; 4coder-like bindings
(global-set-key (kbd "C-o")   'ido-find-file)
(global-set-key (kbd "M-o")   'ido-find-file-other-window)
(global-set-key (kbd "C-S-o") 'revert-buffer)
(global-set-key (kbd "C-b")   'ido-switch-buffer)
(global-set-key (kbd "M-b")   'ido-switch-buffer-other-window)
(global-set-key (kbd "C-,")   'other-window)
(global-set-key (kbd "C-1")   (lambda () (interactive) (switch-to-buffer-other-window (current-buffer))))
(global-set-key (kbd "C-f")   'isearch-forward)
(global-set-key (kbd "C-S-f") 'ag)
(global-set-key (kbd "C-s")   'save-buffer)
(global-set-key (kbd "C-S-s") (lambda () (interactive) (save-some-buffers t)))
(global-set-key (kbd "C-:")   'goto-line)
(global-set-key (kbd "C-t")   'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-a")   'replace-string)
(global-set-key (kbd "M-S-m") 'first-error)
(global-set-key (kbd "M-N")   'previous-error)
(global-set-key (kbd "M-n")   'next-error)
(global-set-key (kbd "C-S-i") 'imenu)
(global-set-key (kbd "M-1")   'find-file-at-point)
(global-set-key (kbd "M-m")   (lambda () (interactive) (compile "./build.sh")))
(global-set-key (kbd "M-]")   'beginning-of-defun)
(global-set-key (kbd "M-'")   'end-of-defun)
(global-set-key (kbd "M-}")   'beginning-of-defun)
(global-set-key (kbd "M-\"")   'end-of-defun)

; TODO and NOTE inserts
(setq mjh-comment-string "//")
(global-set-key (kbd "C-x t") (lambda () (interactive) (insert mjh-comment-string " TODO(") (insert (format-time-string "%Y%m%d")) (insert " helsperm): ")))
(global-set-key (kbd "C-x y") (lambda () (interactive) (insert mjh-comment-string " NOTE(") (insert (format-time-string "%Y%m%d")) (insert " helsperm): ")))

(defun mjh-python-hook ()
  (define-key python-mode-map (kbd "M-]")  'python-nav-backward-block)
  (define-key python-mode-map (kbd "M-'")  'python-nav-forward-block)
  (define-key python-mode-map (kbd "M-}")  'python-nav-backward-defun)
  (define-key python-mode-map (kbd "M-\"") 'python-nav-forward-defun)

  (setq mjh-comment-string "#")
  (setq tab-width 4)
  (setq python-indent-guess-indent-offset nil)

  (defun mjh-python-new-file ()
	 "New Python file format"
	 (interactive)
	 (insert "# -*- coding: utf-8 -*-\n")
	 (insert "\"\"\"\n")
	 (insert (concat (file-name-nondirectory buffer-file-name) "\n\n"))
	 (insert "    :author: Marshel Helsper <helsperm@dnb.com>\n")
	 (insert (concat "    :created: " (format-time-string "%d %B %Y") "\n"))
	 (insert (concat "    :copyright: (c) " (format-time-string "%Y") " Dun & Bradstreet Inc.\n"))
	 (insert "\"\"\"\n\n")
	 (insert "from __future__ import print_function\n")
 	 (insert "\nimport logging\n")
	 (insert "\n\n")
  )

  (when (not (file-exists-p buffer-file-name)) (mjh-python-new-file))
  )

(defun mjh-c++-hook ()
  (c-set-style "stroustrup")
  (setq c-basic-offset 4
	tab-width 4
	indent-tabs-mode nil
	)
  (c-toggle-auto-hungry-state -1)
  (c-set-offset 'case-label '+)

  (define-key c++-mode-map (kbd "TAB") 'dabbrev-expand)
  (define-key c++-mode-map (kbd "<S-tab>") 'indent-for-tab-command)
  (define-key c++-mode-map (kbd "<C-tab>") 'indent-region)

  (defun mjh-c-new-file ()
    (interactive)
    (insert "// ==================================================================================\n")
    (insert "// $File: ") (insert (file-name-nondirectory buffer-file-name)) (insert" $\n")
    (insert "// $Date: ") (insert (format-time-string "%d %B %Y")) (insert " $\n")
    (insert "// $Revision: $\n")
    (insert "// $Creator: Marshel Helsper <helsperm@dnb.com> $\n")
    (insert "// $Notice: (c) ") (insert (format-time-string "%Y")) (insert " Dun & Bradstreet Inc. $\n")
    (insert "// ==================================================================================\n")
    (insert "\n")
    )

  (when (not (file-exists-p buffer-file-name)) (mjh-c-new-file))
  )

(defun mjh-go-hook ()
  (setq tab-width 4)

  (setenv "GOPATH" "/Users/helsperm/Documents/Projects/golang")

  (define-key go-mode-map (kbd "M-m") (lambda () (interactive) (compile "go build")))

  (defun mjh-go-new-file ()
    "New Go file format"
    (interactive)
    (insert "// ==================================================================================\n")
    (insert "// $File: ") (insert (file-name-nondirectory buffer-file-name)) (insert" $\n")
    (insert "// $Date: ") (insert (format-time-string "%d %B %Y")) (insert " $\n")
    (insert "// $Revision: $\n")
    (insert "// $Creator: Marshel Helsper <helsperm@dnb.com> $\n")
    (insert "// $Notice: (c) ") (insert (format-time-string "%Y")) (insert " Dun & Bradstreet Inc. $\n")
    (insert "// ==================================================================================\n")
    (insert "\n")
    )

  (when (not (file-exists-p buffer-file-name)) (mjh-go-new-file))
  )

; Hooks
(add-hook 'python-mode-hook 'mjh-python-hook)
(add-hook 'c-mode-common-hook 'mjh-c++-hook)
(add-hook 'go-mode-hook 'mjh-go-hook)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (graphviz-dot-mode yaml-mode markdown-mode go-mode ag)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun explain-auto-mode (file)
  "Explain in which mode FILE gets visited according to `auto-mode-alist'.
With prefix arg, prompt the user for FILE; else, use function `buffer-file-name'."
  (interactive
   (list
    (if current-prefix-arg
	(read-file-name "Explain the automatic mode of (possibly non-existing) file: " )
      (buffer-file-name))))

 (if (equal "" file)
   (error "I need some file name to work with"))

 (let* ((file (expand-file-name file))
	(index 0)
	assoc)
   (setq assoc
	 (catch 'match
	   (while (setq assoc (nth index auto-mode-alist))
	     (if (string-match (car assoc) file)
		 (throw 'match assoc)
	       (setq index (1+ index))))
	   (setq assoc nil)))

   (if assoc
       (message "First match in `auto-mode-alist' is at position %d:
\"%s\"  <=>  \"%s\".
The corresponding mode is `%s'."
		(1+ index)
		file (car assoc)
		(cdr assoc))
     (message "No match in `auto-mode-alist' for %s." file))))
