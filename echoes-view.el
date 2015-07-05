;; -*- lexical-binding: t -*-



(defun echoes-of-emacs--btn--up ()
  (interactive)
  (funcall echoes-loop-function
           #'(lambda (game)
               
               )))

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
  (make-local-variable 'echoes-loop-function))

(defun echoes-get-or-create-world-buffer (world)
  (if (slot-boundp world :buffer)
      (oref world :buffer)
    (let ((buffer (get-buffer-create "*Echoes of Emacs*")))
      (with-current-buffer buffer
        (echoes-of-emacs-mode))
      (oset world :buffer buffer)
      buffer)))

(defun echoes-render-world (world)
  (let ((buffer (echoes-get-or-create-world-buffer world))
        (width  (oref world width))
        (height (oref world height))
        (entities (oref world entities)))
    (let ((inhibit-read-only t))
      (with-current-buffer buffer
        (echoes-render-initialize-spaces width height)
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

(defun echoes-render-initialize-spaces (width height)
  (erase-buffer)
  (cl-loop
   for row from 1 to height do
   (cl-loop
    for col from 1 to width do
    (insert " "))
   (insert "\n")))

(provide 'echoes-view)
