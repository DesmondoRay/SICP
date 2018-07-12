;;; exercise 1.18

(define (fast-mult a b)
  (fast-iter a b 0))

(define (fast-iter a b n)
  (cond ((= 0 b) n)
        ((even? b) (fast-iter (double a) (halve b) n))
        (else (fast-iter a (+ b -1) (+ n a)))))

(define (double a) (+ a a))
(define (halve b) (/ b 2))

;; test
(load "common/print.scm") ; print过程接受多个参数并打印所有参数的结果

(print 
 (fast-mult 3 5)
 (fast-mult 5 10)
 (fast-mult 7 4038204830284023854023850242352))
; 结果:
;	15
;	50
;	28267433811988166978166951696464
