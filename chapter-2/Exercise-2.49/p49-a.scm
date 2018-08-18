(load "../Exercise-2.48/p48.scm")
(load "2-2-4.scm")

(define top-left (make-vect 0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0 0))
(define bottom-right (make-vect 1.0 0))

(define top (make-segment top-left top-right))
(define left (make-segment top-left bottom-left))
(define right (make-segment top-right bottom-right))
(define bottom (make-segment bottom-left bottom-right))

(segments->painter (list top left right bottom))