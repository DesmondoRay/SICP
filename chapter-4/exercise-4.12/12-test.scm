;;; exercise 4.12 test

(load "../exercise-4.03/3.scm")
(load "12.scm")

;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define a 5)
*** 4.12 test -- define-variable! ***
;;; M-Eval value: 
ok

;;; M-Eval input: 
a
*** 4.12 test -- lookup-variable-value ***
;;; M-Eval value: 
5

;;; M-Eval input: 
(set! a 6)
*** 4.12 test -- set-variable-value! ***
;;; M-Eval value: 
ok

;;; M-Eval input: 
a
*** 4.12 test -- lookup-variable-value ***
;;; M-Eval value: 
6
