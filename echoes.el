;; use `clone` for duping eieio objects
(require 'eieio)

(defun echoes-of-emacs-start ()
  "something"
  (interactive)
  (let* ((entities
          (list
           (echoes-entity "player"
                          :char "@"
                          :x 1
                          :y 1)
           (echoes-entity "tree"
                          :char "t"
                          :x 1
                          :y 2)))
         (world
          (echoes-world "the world"
                        :width 100
                        :height 50
                        :entities entities))
         (game
          (echoes-game "the game"
                       :world world)))
    (echoes-render-world world)))

(defclass echoes-game ()
  ((world :initarg :world)))

(defclass echoes-game-params ()
  ((width :initarg :width)
   (height :initarg :height)))

(defclass echoes-entity ()
  ((char :initarg :char)
   (x :initarg :x)
   (y :initarg :y)))

(defclass echoes-world ()
  ((entities :initarg :entities)
   (width    :initarg :width)
   (height   :initarg :height)))

(defun echoes-render-world (world)
  (let ((buffer (get-buffer-create "*Echoes of Emacs*"))
        (width  (oref world width))
        (height (oref world height))
        (entities (oref world entities)))
    (with-current-buffer buffer
      (echoes-render-initialize-spaces width height)
      (-each entities
        (lambda (ent)
          (echoes-render-entity ent))))))

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

(provide 'echoes)


(defun echoes-window-size-change (frame)
  (message "called"))

(add-to-list 'window-size-change-functions
             #'echoes-window-size-change)
