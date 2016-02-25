;; -*- lexical-binding: t -*-

(let ((echoes-directory (file-name-directory (or load-file-name
                                                (buffer-file-name)))))
  (defun echoes-devel-reload-files ()
    (interactive)
    (let ((load-path (cons echoes-directory load-path)))
      (load "echoes-model")
      (load "echoes-view")
      (load "echoes")))

  (defun echoes-devel-reload-then-start ()
    (interactive)
    (echoes-devel-reload-files)
    (echoes-devel-start))

  (defun echoes-devel-start ()
    "start a game using development stuff."
    (interactive)
    (setq debug-on-error t)
    (echoes-devel-reload-files)
    (echoes-of-emacs-start))

  (defun echoes-devel-setup ()
    "set up some niceities for development. Call to set up development things."
    (interactive)
    (global-set-key (kbd "s-s") #'echoes-devel-start)))



