;;; exercise-27.scm

(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (square (expmod base (/ exp 2) m))
					m))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))

(define (carmichael-check n)
  (define (iter a n)
	(cond ((= a n) true)
		  ((test a n)
		   (iter (+ a 1) n))
		  (else false)))
  (define (test a n)
    (= (expmod a n n) a))
  (iter 1 n))

;; test
(load "common/print.scm")
(print
 (carmichael-check 561)
 (carmichael-check 1105)
 (carmichael-check 1729)
 (carmichael-check 2465)
 (carmichael-check 2821)
 (carmichael-check 6601))
#| 结果:
	#t
	#t
	#t
	#t
	#t
	#t
|#