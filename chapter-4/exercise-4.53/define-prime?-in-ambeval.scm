;;; define-prime?-in-ambeval.scm

;; 定义 prime-sum-pair
(ambeval
 '(define (prime-sum-pair lst1 lst2)
    (let ((a (an-element-of lst1))
          (b (an-element-of lst2)))
      (require (prime? (+ a b)))
      (list a b)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

;; 定义 prime?
(ambeval
 '(define (prime? n)
    (define (smallest-divisor n)
      (find-divisor n 2))
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (define (divides? test-divisor n)
      (= (remainder n test-divisor) 0))
    (= n (smallest-divisor n)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))
