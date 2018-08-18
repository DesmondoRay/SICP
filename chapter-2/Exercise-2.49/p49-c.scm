(load "../Exercise-2.48/p48.scm")
(load "2-2-4.scm")

(define top-mid-point (make-vect 0.5 1.0))
(define bottom-mid-point (make-vect 0.5 0.0))
(define left-mid-point (make-vect 0.0 0.5))
(define right-mid-point (make-vect 1.0 0.5))

(define top-to-left (make-segment top-mid-point
                                  left-mid-point))

(define top-to-right (make-segment top-mid-point
                                   right-mid-point))

(define bottom-to-left (make-segment bottom-mid-point
                                     left-mid-point))

(define bottom-to-right (make-segment bottom-mid-point
                                      right-mid-point))

(segments->painter (list top-to-left
                         top-to-right
                         bottom-to-left
                         bottom-to-right))