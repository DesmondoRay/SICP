;;; 55.scm

(load "../common/integers.scm")
(load "../common/add-streams.scm")

(define (stream-same x)
  (cons-stream x (stream-same x)))

(define (partial-sums S)
  (cons-stream (stream-car S)
			   (add-streams (stream-cdr S)
							(partial-sums S))))

;; test

(stream-head (partial-sums integers) 10)
; 结果: (1 3 6 10 15 21 28 36 45 55)
