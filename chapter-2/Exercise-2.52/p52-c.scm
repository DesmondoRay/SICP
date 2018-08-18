(load "../Exercise-2.50/p50.scm")
(load "p52-b.scm")

(define (square-limit painter n)
    (let ((combine4 (square-of-four identity flip-horiz
                                    flip-vect rotate180)))
        (combine4 (corner-split painter n))))