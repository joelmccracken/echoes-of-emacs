;; -*- lexical-binding: t -*-

;; use `clone` for duping eieio objects
(require 'eieio)

(require 'echoes-model)
(require 'echoes-view)


(defvar echoes-current-game nil
  "The current game.
This is a buffer-local variable so that commands run from
a buffer can determine the running game.")

(defun echoes-of-emacs-start ()
  "start playing echoes!"
  (interactive)
  (let* ((game (echoes-build-game))
         (world (oref game
                      world))
         (world-buffer (echoes-create-world-buffer)))
    (pop-to-buffer world-buffer)
    (echoes-render-world world world-buffer)))

(defun echoes-loop (fn)
  (setq (funcall fn))
  (echoes-render-world world))

(provide 'echoes)

