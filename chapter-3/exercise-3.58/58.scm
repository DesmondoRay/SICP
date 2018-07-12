;;; 58.scm

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

;; test
(stream-head (expand 1 7 10) 13)
; 结果: (1 4 2 8 5 7 1 4 2 8 5 7 1)
; (1 4 2 8 5 7) 的循环

(stream-head (expand 3 8 10) 10)
; 结果: (3 7 5 0 0 0 0 0 0 0)