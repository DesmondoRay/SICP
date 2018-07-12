;;; 59-a.scm

(load "../common/integers.scm")

(define (mul-streams s1 s2)
  (stream-map / s1 s2))

(define (integrate-series s)
  (mul-streams s integers))

(define ones (cons-stream 1 ones))

;; test
(stream-head (integrate-series ones) 10)
; 结果: (1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10)