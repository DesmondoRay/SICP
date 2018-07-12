;;; exercise 1.19

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 p q) (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

;; test
(load "common/print.scm") ; print过程接受多个参数并打印所有参数的结果

(print 
 (fib 5)
 (fib 7)
 (fib 12))
; 结果:
;	5
;	13
;	144