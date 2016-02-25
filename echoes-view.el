;; -*- lexical-binding: t -*-

(defun echoes-of-emacs--btn--up ()
  (interactive)
  (echoes--message 'btn-up))

(defvar echoes-of-emacs-current-state nil
  "Variable to contain the echoes state")


(defvar echoes-of-emacs-mode-map nil
  "Keymap for echoes of emacs buffers.")
(setq echoes-of-emacs-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "<up>") #'echoes-of-emacs--btn--up)
        map))

(define-derived-mode echoes-of-emacs-mode special-mode "Echoes"
  "Mode for Echoes of Emacs game.

\\{echoes-of-emacs-mode-map}
Another line of documentation."
  (make-local-variable 'echoes-current-win-width)
  (make-local-variable 'echoes-current-win-height)
  (make-local-variable 'echoes-game-state))

(defun echoes-create-world-buffer (game)
  (let ((buffer (get-buffer-create "*Echoes of Emacs*")))
    (with-current-buffer buffer
      (echoes-of-emacs-mode)
      (setq echoes-game-state game))
    buffer))

(defun echoes-render-world (world-buffer)
  (let ((inhibit-read-only t))
    (with-current-buffer world-buffer
      (let* ((buffer world-buffer)
             (world (oref echoes-game-state world))
             (width  (oref world width))
             (height (oref world height))
             (entities (oref world entities)))
        (echoes-clear-buffer-and-render-spaces width height)
        (-each entities
          (lambda (ent)
            (echoes-render-entity ent)))))))

(defmethod echoes-render-entity ((ent echoes-entity))
  (let ((x (oref ent :x))
        (y (oref ent :y))
        (char (oref ent :char)))
    (goto-char (point-min))
    (next-line y)
    (forward-char x)
    (delete-char 1)
    (insert char)))

(defun echoes-clear-buffer-and-render-spaces (width height)
  (erase-buffer)
  (cl-loop
   for row from 1 to height do
   (cl-loop
    for col from 1 to width do
    (insert " "))
   (insert "\n")))

(provide 'echoes-view)
