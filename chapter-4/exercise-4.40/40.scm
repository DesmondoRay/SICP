;;; exercise 4.40

(define (multiple-dwelling)
  (let ((cooper (amb 2 3 4 5))
        (miller (amb 1 2 3 4 5)))
    (require (> miller cooper))
    (let ((fletcher (amb 2 3 4)))
      (require (not (= (abs (- fletcher cooper)) 1)))
      (let ((smith (amb 1 2 3 4 5)))
        (require (not (= (abs (- smith fletcher)) 1)))
        (let ((baker (amb 1 2 3 4)))
          (require
           (distinct? (list baker cooper fletcher miller smith)))
          (list (list 'baker baker)
                (list 'cooper cooper)
                (list 'fletcher fletcher)
                (list 'miller miller)
                (list 'smith smith)))))))

;; test
(load "../common/amb-evaluator.scm") ; 由4.3.3实现

(driver-loop)
#|
;;; Amb-Eval input:
(define (test-once)
  (let ((start-time (runtime)))
    (newline)
    (display (multiple-dwelling))
    (newline)
    (display "runtime: ")
    (display (- (runtime) start-time))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: .15000000000000002
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: .14
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: .1399999999999999
;;; Amb-Eval value:
#!unspecific
|#