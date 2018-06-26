(load "2-2-3.scm")
(load "p36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))