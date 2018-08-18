(load "p29-c.scm")

(define l1 (make-branch 3 2))
(define r1 (make-branch 2 3))
(define m1 (make-branch l1 r1))

(define l (make-branch 3 m1))
(define r (make-branch 5 3))
(define m (make-mobile l r))

(newline)
(display (balance? m))

;; output: #t