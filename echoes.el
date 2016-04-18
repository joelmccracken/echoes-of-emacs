;; -*- lexical-binding: t -*-

;; use `clone` for duping eieio objects
(require 'eieio)

(require 'cask)

(require 'dash)

(require 'echoes-model)
(require 'echoes-view)
(require 'accessors)


(defvar echoes-current-game nil
  "The current game.
This is a buffer-local variable so that commands run from
a buffer can determine the running game.")

(defun echoes-of-emacs-start ()
  "start playing echoes!"
  (interactive)
  (let* ((world-buffer (echoes-create-world-buffer)))
    (pop-to-buffer world-buffer)
    (echoes--message `(initialize ,world-buffer))))

(defun echoes--message (message)
  "Send a message to update the state of the game.

Invokes echoes--update. What echoes--update returns is
set as the next state."
  (setq echoes-current-game
        (echoes--update echoes-current-game
                        message))
  (echoes-render-world (oref echoes-current-game buffer)
                       echoes-current-game))


(defun echoes--update (state msg)
  (setq result
        (pcase msg
          (`(initialize ,buffer)
           (let ((game (echoes-build-game)))
             (clone game :buffer buffer)))
          (`btn-up

           nil)
          (`btn-left :left)
          (`btn-right :right)
          (`btn-down :down)))
  (message "Got: %s; result: %s" msg result)
  result)









(provide 'echoes)
