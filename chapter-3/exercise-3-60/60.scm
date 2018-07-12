;;; 60.scm

(load "../exercise-3.59/59-b.scm")
(load "../common/add-streams.scm")

;; 类似于多项式的乘法，s1的第一项与s2的所有数相乘，加上s1的第二项与s2的所有项相乘，...
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
			   (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
							(mul-series (stream-cdr s1) s2))))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

;; test: sin2x + cos2x = 1
(define square-sin (mul-series sine-series sine-series))
(define square-cos (mul-series cosine-series cosine-series))
(define sum (add-streams square-sin square-cos))

(stream-head sum 10)
; 结果: (1 0 0 0 0 0 0 0 0 0)

