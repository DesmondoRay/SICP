;;; 64.scm

(load "sqrt-stream.scm")

(define (stream-limit stream num)
  (if (stream-null? stream)
	  false
	  (let ((first (stream-car stream))
			(rest (stream-cdr stream)))
		(if (stream-null? rest)
			false
			(if (< (abs (- first (stream-car rest)))
				   num)
				(stream-car rest)
				(stream-limit rest num))))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

;; test
(sqrt 2 0.001)
;Value: 1.4142135623746899
