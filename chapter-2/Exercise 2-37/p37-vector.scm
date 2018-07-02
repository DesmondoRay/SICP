(load "p37.scm")

(define (matrix-*-vertor m v)
  (map (lambda (x)
         (dot-product x v))
       m))