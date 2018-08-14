;;; exercise 1.32 a

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (term a) a)
(define (inc a) (+ a 1))


#| test:
1 ]=> (accumulate + 0 term 1 inc 5)

;Value: 15

1 ]=> (accumulate * 1 term 1 inc 5)

;Value: 120
|#