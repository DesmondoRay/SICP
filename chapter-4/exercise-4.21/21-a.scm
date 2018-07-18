;;; exercise 4.21 a)

;; fact
(newline)
(display 
 ((lambda (n)
    ((lambda (fact)
       (fact fact n))
     (lambda (ft k)
       (if (= k 1)
           1
           (* k (ft ft (- k 1)))))))
  10))
; output: 3628800

;; fib:
(newline)
(display
 ((lambda (n)
    ((lambda (fib)
       (fib fib n))
     (lambda (fb k)
       (if (< k 2)
           k
           (+ (fb fb (- k 1)) (fb fb (- k 2)))))))
  5))

; output: 5