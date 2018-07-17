;;; exercise 4.11 test

;; 测试比较麻烦，为了不影响其他练习的测试，将所有需要修改到文件复制到当前文件夹
; 修改evaluator-data-structures.scm： 在末尾加载(load "11.scm")，相当于替换原本的定义
; 修改3.scm：在(load "../common/running-evaluator.scm")之前，
; 加载修改后的(load "evaluator-data-structures.scm")   

(load "modify-3.scm")

(driver-loop)

;;; M-Eval input: 
(define a 5)
*** 4.11 test -- add-binding-to-frame! ***
;;; M-Eval value: 
ok

;;; M-Eval input: 
(define b 3)
*** 4.11 test -- add-binding-to-frame! ***
;;; M-Eval value: 
ok

;;; M-Eval input: 
a

;;; M-Eval value: 
5

;;; M-Eval input: 
b

;;; M-Eval value: 
3

;;; M-Eval input: 

