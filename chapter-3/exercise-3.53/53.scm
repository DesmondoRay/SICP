;;; 53.scm

(load "..common/add-streams.scm")

(define s (cons-stream 1 (add-streams s s)))

;; s: 1 2 4 8 16...

(load "../common/print.scm")

(print (stream-car s)
       (stream-car (stream-cdr s))
       (stream-car (stream-cdr (stream-cdr s))))
; 输出:
;   1
;   2
;   4