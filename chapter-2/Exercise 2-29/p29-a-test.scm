(load "p29-a.scm")

(define a (make-branch 2 3))
(define b (make-branch 4 5))
(define m (make-mobile a b))

(display (left-branch m))
(newline)
(display (branch-length (left-branch m)))
(newline)
(display (branch-structure (left-branch m)))
(newline)

(display (right-branch m))
(newline)
(display (branch-length (right-branch m)))
(newline)
(display (branch-structure (right-branch m)))
(newline)
