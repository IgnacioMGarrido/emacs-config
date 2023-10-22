;; init.el --- Nacho's Emacs setup.  -*- lexical-binding: t; -*-

(when (eq system-type 'darwin)
  (setq ns-auto-hide-menu-bar t))

(defun reload-config ()
  "Reload the literate config from ~/.emacs.d/config.org."
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))

(setq max-lisp-eval-depth 2000)

(reload-config)
(provide 'init)
;;; init.el ends here
