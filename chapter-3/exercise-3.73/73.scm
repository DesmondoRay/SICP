;;; 73.scm

(load "../common/add-streams.scm")
(load "../common/scale-stream.scm")
(load "integral.scm")

(define (RC R C dt)
  (lambda (i v0)
	(define v
	  (add-streams (scale-stream i R)
				   (integral (scale-stream i (/ 1 C)) v0 dt)))
	v))

(define RC1 (RC 5 1 0.5))

(load "../common/integers.scm")
(define v1 (RC1 integers 1))

(stream-head v1 5)
;Value: (6 11.5 17.5 24. 31.)

