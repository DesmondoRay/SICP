;;; exercise 1.39

(define (tan-cf x k)
  (define (iter k result)
    (if (= k 1)
        (/ x (- 1 result))
        (iter (- k 1) (/ (square x) (- (- (* k 2) 1) result)))))
  (iter k 0))


#| test:
1 ]=> (tan-cf 1.0 10)

;Value: 1.557407724654902
|#