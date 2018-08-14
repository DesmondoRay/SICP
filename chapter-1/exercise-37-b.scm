;;; exercise 1.37 b

(define tolerance 0.00001)

(define (cont-frac f1 f2 k)
  (define (iter k result)
    (if (= k 0)
        result
        (iter (- k 1) (/ (f1 k) (+ (f2 k) result)))))
  (iter k 0))


#| test:
1 ]=> (cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)

;Value: .6180257510729613
|#