(load "p8.scm")

(define (width x)
  (/ (- (upper-bound x) (lower-bound x))
     2))
