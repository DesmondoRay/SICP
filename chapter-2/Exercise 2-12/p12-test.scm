(load "p9-width.scm")
(load "make-center-width.scm")

(define (make-center-percent c p)
  (make-interval (- c (* c p))
                 (+ c (* c p))))

(define (percent a)
  (/ (width a)
     (/ (+ (upper-bound a) (lower-bound a))
        2)))


(define interval (make-center-percent 100 0.05))
(display (lower-bound interval))
(newline)
(display (upper-bound interval))
(newline)
(display (percent interval))
(newline)