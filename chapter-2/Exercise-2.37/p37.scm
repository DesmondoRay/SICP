(load "../common/2-2-3.scm")
(load "../Exercise-2.36/p36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))