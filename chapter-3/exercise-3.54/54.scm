;;; 54.scm

(load "../common/integers.scm")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams integers factorials)))


;; test
(load "../common/print.scm")

(print 
 (stream-ref factorials 3)
 (stream-ref factorials 5)
 (stream-ref factorials 7))
; 输出:
;   6
;   120
;   5040

