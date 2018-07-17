;;; 52.scm

(load "../common/stream-enumerate-interval.scm")
(load "../common/display-stream.scm")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))

(stream-ref y 7)
;Value: 136

(display-stream z)
#|
输出:
    10
    15
    45
    55
    105
    120
    190
    210
|#

; 不使用memo-proc所提供的优化，对seq流的求值就会产生重复计算，
; 从而导致accum中set!过程得到不同的sum值;