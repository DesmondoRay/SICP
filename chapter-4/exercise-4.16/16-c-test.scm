;;; exercise 4.16 c)

(load "16-b.scm")
(load "16-c.scm")

;; test
(driver-loop)

;;; M-Eval input: 
(define (a n)
  (define b 3)
  (define c 2)
  (+ b c n))
*** 4.16 test -- make-procedure ***
;;; M-Eval value: 
ok

;;; M-Eval input: 
(a 1)
*** 4.16 test -- make-procedure ***
;;; M-Eval value: 
6