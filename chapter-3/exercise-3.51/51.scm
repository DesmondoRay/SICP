;;; 51.scm

(load "../common/stream-enumerate-interval.scm")
(load "../common/display-stream.scm")

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)
#|
输出:
	1
	2
	3
	4
	5
	;Value: 5
|#

(stream-ref x 7)
#|
输出:
	6
	7
	;Value: 7
|#
