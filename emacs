; Global settings

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
(setq tab-stop-list nil)
(setq tab-width 4)
(setq make-backup-files nil)
(setq auto-save-default nil)
;(setq default-directory "~/Documents/Projects")
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks t)

(set-frame-font "-*-Liberation Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")

					; Emacs Window Things
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(toggle-frame-maximized)
(global-hl-line-mode 1)

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
;(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")

(require 'cc-mode)
(require 'compile)
(require 'ido)
(require 'ag)
(ido-mode t)

(setq ag-reuse-buffers 't)

(defun mjh-never-split-a-window ()
    "Just don't do it man"
  nil)
(setq split-window-preferred-function 'mjh-never-split-a-window)

; Key mappings
(global-set-key (kbd "<C-right>") 'forward-word)
(global-set-key (kbd "<C-left>") 'backward-word)
(global-set-key (kbd "<C-down>") 'forward-paragraph)
(global-set-key (kbd "<C-up>") 'backward-paragraph)
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "<pgup>") 'forward-page)
(global-set-key (kbd "<pgdown>") 'backward-page)
(global-set-key (kbd "<C-next>") 'scroll-other-window)
(global-set-key (kbd "<C-prior>") 'scroll-other-window-down)
(global-set-key (kbd "<S-tab>") 'dabbrev-expand)

; 4coder-like bindings
(global-set-key (kbd "C-o")   'ido-find-file)
(global-set-key (kbd "M-o")   'ido-find-file-other-window)
(global-set-key (kbd "C-S-o") 'revert-buffer)
(global-set-key (kbd "C-b")   'ido-switch-buffer)
(global-set-key (kbd "M-b")   'ido-switch-buffer-other-window)
(global-set-key (kbd "C-,")   'other-window)
(global-set-key (kbd "C-f")   'isearch-forward)
(global-set-key (kbd "C-S-f") 'ag)
(global-set-key (kbd "C-s")   'save-buffer)
(global-set-key (kbd "C-S-s") (lambda () (interactive) (save-some-buffers t)))
(global-set-key (kbd "C-:")   'goto-line)
(global-set-key (kbd "C-t")   'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-a")   'replace-string)
;(global-set-key (kbd "C-m")   'exchange-point-and-mark) ; For some reason, this also replaces RET?
(global-set-key (kbd "M-S-m") 'first-error)
(global-set-key (kbd "M-S-n") 'prev-error)
(global-set-key (kbd "M-n")   'next-error)
(global-set-key (kbd "C-S-i") 'imenu)
(global-set-key (kbd "M-1") 'find-file-at-point)

(defun mjh-python-hook ()
  (define-key python-mode-map (kbd "M-]")  'python-nav-backward-block)
  (define-key python-mode-map (kbd "M-'")  'python-nav-forward-block)
  (define-key python-mode-map (kbd "M-}")  'python-nav-backward-defun)
  (define-key python-mode-map (kbd "M-\"") 'python-nav-forward-defun)
  (setq tab-wdith 4)
  )

(defun mjh-c-hook ()
    (define-key c-mode-map (kbd "M-m") (lambda () (interactive) (compile "./build.sh")))
  )

(defun mjh-go-hook ()
  (define-key go-mode-map (kbd "M-]") 'beginning-of-defun)
  (define-key go-mode-map (kbd "M-'") 'end-of-defun)
  (define-key go-mode-map (kbd "M-}") 'beginning-of-defun)
  (define-key go-mode-map (kbd "M-\"") 'end-of-defun)
  (define-key go-mode-map (kbd "M-m") (lambda () (interactive) (compile "go build")))
  (setq tab-width 4)
  )

; Hooks
(add-hook 'python-mode-hook 'mjh-python-hook)
(add-hook 'c-mode-hook 'mjh-c-hook)
(add-hook 'go-mode-hook 'mjh-go-hook)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (go-mode ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
