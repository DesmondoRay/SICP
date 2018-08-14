;;; exercise 1.28

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((nontrivial-square-root base m)
         0)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (nontrivial-square-root a n)
  (and (not (= a 1))
       (not (= a (- n 1)))
       (= 1 (remainder(square a) n))))

(define (miller-rabin-test n)
  (if (odd? n)
	  (test-iter n (/ (+ n 1) 2))
	  (test-iter n (/ n 2))))

(define (test-iter n times)
  (cond ((= times 0) true)
		; (+ 1 (random (- n 1))) 相当于从1到n取随机数
		((= (expmod (+ 1 (random (- n 1))) (- n 1) n) 1)
		 (test-iter n (- times 1)))
		(else false)))


#| test
1 ]=> (miller-rabin-test 103)

;Value: #t

1 ]=> (miller-rabin-test 561)

;Value: #f

1 ]=> (miller-rabin-test 1105)

;Value: #f

1 ]=> (miller-rabin-test 1729)

;Value: #f

1 ]=> (miller-rabin-test 2465)

;Value: #f

1 ]=> (miller-rabin-test 2821)

;Value: #f

1 ]=> (miller-rabin-test 6601)

;Value: #f
|#