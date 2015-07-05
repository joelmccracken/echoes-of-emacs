;; -*- lexical-binding: t -*-

(defun echoes-build-game ()
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
                        :width 10
                        :height 10
                        :entities entities)))
    (echoes-game "the game"
                 :world world)))

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
   (height   :initarg :height)
   (buffer   :initarg :buffer)))


(provide 'echoes-model)
