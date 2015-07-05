(require 'ert)

(require 'echoes)

(ert-deftest foo-bar ()
  (should (echoes-of-emacs-start)))


(ert-deftest game-test ()
  (echoes-game)
  )



