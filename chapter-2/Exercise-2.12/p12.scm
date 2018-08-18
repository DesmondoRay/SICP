(load "../Exercise-2.09/p9-width.scm")
(load "../Exercise-2.11/p11.scm")
(load "../common/make-center-width.scm")

(define (make-center-percent c p)
  (make-interval (- c (* c p))
                 (+ c (* c p))))

(define (percent a)
  (/ (width a)
     (/ (+ (upper-bound a) (lower-bound a))
        2)))