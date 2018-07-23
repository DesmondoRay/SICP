;;; exercise 4.36
;; 简单地替换，可能会造成系统一直运行下去，00

(define (a-pythagorean-triple-from n)
  (let ((k (an-integer-starting-from n)))
    (let ((j (an-integer-between n k)))
      (let ((i (an-integer-between n j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

;; test
(load "../common/amb-evaluator.scm") ; 由4.3.3实现
(driver-loop)
#|
;;; Amb-Eval input:
(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

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
(define (a-pythagorean-triple-from n)
  (let ((k (an-integer-starting-from n)))
    (let ((j (an-integer-between n k)))
      (let ((i (an-integer-between n j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(a-pythagorean-triple-from 1)

;;; Starting a new problem 
;;; Amb-Eval value:
(3 4 5)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(6 8 10)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(5 12 13)
|#