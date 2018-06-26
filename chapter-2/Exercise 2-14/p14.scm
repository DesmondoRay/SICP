(load "p14-two-ways.scm")

(define A (make-interval 10 11))
(define B (make-interval 10 11))

(define way1 (par1 A B))
(define way2 (par2 A B))

(display (width way1))
(newline)
(display (width way2))
(newline)
