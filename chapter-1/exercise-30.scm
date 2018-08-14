;;; exercise 1.30

(define (sum term a next b)
  (define (iter a result)
    (if (> a b) 
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

;; test
(define (inc a) (+ a 1))
#| output:
1 ]=> (sum square 1 inc 5)

;Value: 55
|# 