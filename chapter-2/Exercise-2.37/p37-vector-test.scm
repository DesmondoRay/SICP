(load "p37-vector.scm")

(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(define v (list 1 2 3 4))

(newline)
(display (matrix-*-vertor m v))

;; output: (30 56 80)