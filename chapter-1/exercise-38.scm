;;; exercise 1.38

(define tolerance 0.00001)

(define (cont-frac f1 f2 k)
  (define (iter k result)
    (if (= k 0)
        result
        (iter (- k 1) (/ (f1 k) (+ (f2 k) result)))))
  (iter k 0))

(define (f-Di i)
  (if (= (remainder (- i 2) 3) 0)
      (* 2 (+ 1 (/ (- i 2) 3)))
      1))

(define (e n)
  (+ 2 (cont-frac (lambda (x) 1.0) f-Di n)))


#| test:
1 ]=> (e 20)

;Value: 2.718281828459045
|#