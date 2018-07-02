(load "p11.scm")

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (center i)
  (/ (- (upper-bound i) (lower-bound i)) 2))