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
 ;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
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
  ;;(require 'compile)
  ;;(require 'cc-mode)
)

(defun reload-config ()
  "Reload the literate config from ~/.emacs.d/config.org."
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))

(setq max-lisp-eval-depth 2000)

(reload-config)
(provide 'init)
;;; init.el ends here
