;;; 62.scm

(load "../exercise-3.61/61.scm")

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "Divide by 0 -- DIV-SERIES" (stream-car s2))
      (mul-series s1
                  (reciprocal-series s2))))

;; test
(define s (stream-enumerate-interval 1 10)) ; s为 1～10 的流
(define ones (cons-stream 1 ones))
(define x (div-series ones s)) ; x 包含10个元素

(load "../common/display-stream.scm")
; 1/x * x = 1
(display-stream (mul-series x s))
#| 输出:
1
1
1
1
1
1
1
1
1
1
|#

;; 正切函数的幂级数
(define tane-series (div-series sine-series cosine-series))

