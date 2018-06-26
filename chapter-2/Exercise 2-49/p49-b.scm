(load "p48.scm")
(load "2-2-4.scm")

(define left-top (make-vect 0.0 1.0))
(define right-bottom (make-vect 1.0 0.0))
(define right-top (make-vect 1.0 1.0))
(define left-bottom (make-vect 0.0 0.0))

(define left-top-to-right-bottom (make-segment left-top
                                               right-bottom))

(define right-top-to-left-bottom (make-segment right-top
                                               left-bottom))

(segments->painter (list left-top-to-right-bottom
                         right-top-to-left-bottom))