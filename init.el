;; init.el --- Nacho's Emacs setup.  -*- lexical-binding: t; -*-


(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(when (eq system-type 'darwin)
  (setq ns-auto-hide-menu-bar t))

(require 'package)
  ;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("ublt" . "https://elpa.ubolonton.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(setq package-native-compile t)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (message "refreshing contents")
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

(require 'server)
(unless (server-running-p) (server-start))
(setq server-use-tcp t)
(defun server-ensure-safe-dir (dir) "Noop" t)

(eval-when-compile
  (require 'use-package)
  (require 'ob-tangle)
  (require 'compile)
  (require 'cc-mode)
)

(defun reload-config ()
  "Reload the literate config from ~/.emacs.d/config.org."
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))

(setq max-lisp-eval-depth 2000)

(reload-config)
(provide 'init)
;;; init.el ends here


;;; Commentary:
;; This file loads use-package, org-mode, and compiles and executes readme.org
;;
;;; Code:
;;
;;
;;;; Fixing emacs defaults
;;(setq
;; ;; No need to see GNU agitprop.
;; inhibit-startup-screen t
;; ;; No need to remind me what a scratch buffer is.
;; initial-scratch-message nil
;; ;; Double-spaces after periods is morally wrong.
;; sentence-end-double-space nil
;; ;; Never ding at me, ever.
;; ring-bell-function 'ignore
;; ;; Save existing clipboard text into the kill ring before replacing it.
;; save-interprogram-paste-before-kill t
;; ;; Prompts should go in the minibuffer, not in a GUI.
;; use-dialog-box nil
;; ;; Fix undo in commands affecting the mark.
;; mark-even-if-inactive nil
;; ;; Let C-k delete the whole line.
;; kill-whole-line t
;; ;; search should be case-sensitive by default
;; case-fold-search nil
;; ;; accept 'y' or 'n' instead of yes/no
;; ;; the documentation advises against setting this variable
;; ;; the documentation can get bent imo
;; use-short-answers t
;; ;; my source directory
;; default-directory "C:/dev"
;; ;; eke out a little more scrolling performance
;; fast-but-imprecise-scrolling t
;; ;; prefer newer elisp files
;; load-prefer-newer t
;; ;; when I say to quit, I mean quit
;; confirm-kill-processes nil
;; ;; if native-comp is having trouble, there's not very much I can do
;; native-comp-async-report-warnings-errors 'silent
;; ;; unicode ellipses are better
;; truncate-string-ellipsis "…"
;; ;; I want to close these fast, so switch to it so I can just hit 'q'
;; help-window-select t
;; ;; this certainly can't hurt anything
;; delete-by-moving-to-trash t
;; ;; keep the point in the same place while scrolling
;; scroll-preserve-screen-position t
;; ;; More dynamic scroll
;; scroll-step 3
;; ;; more info in completions
;; completions-detailed t
;; ;; highlight error messages more aggressively
;; next-error-message-highlight t
;; ;; don't let the minibuffer muck up my window tiling
;; read-minibuffer-restore-windows t
;; ;; scope save prompts to individual projects
;; save-some-buffers-default-predicate 'save-some-buffers-root
;; ;; don't keep duplicate entries in kill ring
;; kill-do-not-save-duplicates t
;; )
;;
;;;; Never mix tabs and spaces. Never use tabs, period.
;;;; We need the setq-default here because this becomes
;;;; a buffer-local variable when set.
;;(setq-default indent-tabs-mode nil)
;;
;;(tool-bar-mode 1)
;;(scroll-bar-mode -1)
;;(menu-bar-mode 1)
;;(global-display-line-numbers-mode 1)
;;
;;(load-theme 'modus-vivendi t)
;;
;;;; set Font
;;(set-face-attribute 'default t :font "Ac437 ToshibaSat 8x14-14")
;;(add-to-list 'default-frame-alist '(font . "Ac437 ToshibaSat 8x14-14"))
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;
;;;; line mode
;;(global-hl-line-mode 1)
;;(set-face-background 'hl-line "midnight blue")
;;(blink-cursor-mode 1)
;;
;;(recentf-mode 1)
;;
;;(setq history-lenght 25)
;;(savehist-mode 1)
;;
;;;; Remember and restore the last position in the file
;;(save-place-mode 1)
;;
;;;; Setup find files
;;(define-key global-map "\ef" 'find-file)
;;(define-key global-map "\eF" 'find-file-other-window)
;;
;;(define-key global-map "\eb" 'ido-switch-buffer)
;;(define-key global-map "\eB" 'ido-switch-buffer-other-window)
;;
;;;; Clock
;;(display-time)
;;
;;
;;;; Startup windowing
;;(setq next-line-add-newlines nil)
;;(setq-default truncate-lines t)
;;(setq truncate-partial-width-windows nil)
;;(split-window-horizontally)
