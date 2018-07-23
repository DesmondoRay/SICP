;;; exercise 4.38
;;; 新谜题有5个解
#|
题目翻译错了，原文为：
Modify the multiple-dwelling procedure to omit(忽略) the requirement 
that Smith and Fletcher do not live on adjacent floors. 
How many solutions are there to this modified puzzle?
|#

(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5)) 
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5)) 
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require
     (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    ; (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher) 
          (list 'miller miller)
          (list 'smith smith))))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

;; test
(load "../common/amb-evaluator.scm") ; 由4.3.3实现

(driver-loop)
#|
;;; Amb-Eval input:
(multiple-dwelling)

;;; Starting a new problem 
;;; Amb-Eval value:
((baker 1) (cooper 2) (fletcher 4) (miller 3) (smith 5))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((baker 1) (cooper 2) (fletcher 4) (miller 5) (smith 3))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((baker 1) (cooper 4) (fletcher 2) (miller 5) (smith 3))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((baker 3) (cooper 4) (fletcher 2) (miller 5) (smith 1))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(multiple-dwelling)
|#