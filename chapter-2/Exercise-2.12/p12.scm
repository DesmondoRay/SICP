(load "p9-width.scm")
(load "make-center-width.scm")

(define (make-center-percent c p)
  (make-interval (- c (* c p))
                 (+ c (* c p))))

(define (percent a)
  (/ (width a)
     (/ (+ (upper-bound a) (lower-bound a))
        2)))