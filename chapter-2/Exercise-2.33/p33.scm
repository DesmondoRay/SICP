(load "2-2-3.scm")

(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y))
                0
                sequence))

(length (list 1 2 3))