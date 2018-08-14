;;; exercise 1.37 a

(define tolerance 0.00001)

(define (cont f1 f2 k i)
  (if (= i k)
      0
     (/ (f1 k) (+ (f2 k) (cont f1 f2 k (+ 1 i))))))

(define (cont-frac f1 f2 k)
  (cont f1 f2 k 1))

#| test:
1 ]=> (cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)

;Value: .6180555555555556
|#