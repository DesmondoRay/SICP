(load "p29-b.scm")

(define a (make-branch 2 3))
(define b (make-branch 4 5))
(define m (make-mobile a b))

(newline)
(display (total-weight m))

;; output: 8