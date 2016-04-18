

(defun oref-world (game &rest args)
  (let ((world (oref game world)))

    (if (not (member :update-below args))
        world
      (oref-world )
      )))

(defun oref-entities (world)
  (oref world entities)
  )

(defun player (entities)
  (-first (lambda (entity)
            (equal
             (oref entity type)
             :player))
          entities))

(defun update (eieio-ent key value)
  (clone eieio-ent key value))

(->
 (echoes-build-game)
 oref-world
 :update (lambda (x) )
 )


(lookup
 (echoes-build-game)
 oref-world
 :update
 )



(oref-world (oref-entities (echoes-build-game)))
