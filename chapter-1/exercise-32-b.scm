;;; exercise 1.31 b

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))


(define (term a) a)
(define (inc a) (+ a 1))

(accumulate + 0 term 1 inc 5)
(accumulate * 1 term 1 inc 5)