;;; 61.scm

(load "../exercise-3.60/60.scm")
(load "../common/stream-enumerate-interval.scm")


(define (reciprocal-series s)
  (cons-stream 1 
               (scale-stream 
                (mul-series (stream-cdr s)
                            (reciprocal-series s))
                -1)))

;; test
(define s (stream-enumerate-interval 1 10)) ; s为 1～10 的流
(define x (reciprocal-series s))
(define s-x (mul-series s x)) ; s-x 包含10个元素

; 前9个数
(display (stream-head s-x 9))
; 结果: (1 0 0 0 0 0 0 0 0)
; 最后一个数
(stream-ref s-x 9)
;Value: 0

