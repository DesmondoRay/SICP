;;; exercise 1.17

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

;; test
(load "common/print.scm") ; print过程接受多个参数并打印所有参数的结果

(print (fast-mult 3 5)
	   (fast-mult 5 10)
	   (fast-mult 7 4038204830284023854023850242352))
; 结果:
;	15
;	50
;	28267433811988166978166951696464
