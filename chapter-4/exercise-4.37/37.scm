;;; exercise 4.37

(load "../common/amb-evaluator.scm") ; 由4.3.3实现

;; test
(driver-loop)
#|
;;; Amb-Eval input:
(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(a-pythagorean-triple-between 1 10)

;;; Starting a new problem 
;;; Amb-Eval value:
(3 4 5)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(6 8 10)

;;; Amb-Eval input:
try-again

;;; There are no more values of
(a-pythagorean-triple-between 1 10)
|#