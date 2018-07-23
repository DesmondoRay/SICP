;;; exercise 4.43

;; test
(load "../common/amb-evaluator.scm")
(driver-loop)

#|
;;; Amb-Eval input:
(define (father-daughter)
  (let ((Moore-daughter    'Mary)
        (Barnacle-daughter 'Melissa)
        (Hall-daughter     (amb 'Gabrielle 'Lorna))
        (Downing-daughter  (amb 'Gabrielle 'Lorna 'Rosalind))
        (Parker-daughter   (amb 'Lorna 'Rosalind)))
    (require (cond ((eq? Hall-daughter 'Gabrielle) 
                    (eq? 'Rosalind Parker-daughter))
                   ((eq? Downing-daughter 'Gabrielle) 
                    (eq? 'Melissa Parker-daughter))
                   (else false)))
    (require 
     (distinct? (list Hall-daughter Downing-daughter Parker-daughter)))
    (list (list 'Barnacle Barnacle-daughter)
          (list 'Moore    Moore-daughter)
          (list 'Hall     Hall-daughter)
          (list 'Downing  Downing-daughter)
          (list 'Parker   Parker-daughter))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(father-daughter)

;;; Starting a new problem 
;;; Amb-Eval value:
((barnacle melissa) (moore mary) (hall gabrielle) (downing lorna) (parker rosalind))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(father-daughter)

|#


;; 未告知Mary Ann的姓是Moore： 两个解
#|
;;; Amb-Eval input:
(define (father-daughter)
  (let ((Moore-daughter    (amb'Mary 'Gabrielle 'Rosalind))
        (Barnacle-daughter 'Melissa)
        (Hall-daughter     (amb 'Gabrielle 'Lorna 'Mary))
        (Downing-daughter  (amb 'Gabrielle 'Lorna 'Rosalind 'Mary))
        (Parker-daughter   (amb 'Lorna 'Rosalind 'Mary)))
    (require (cond ((eq? Hall-daughter 'Gabrielle) 
                    (eq? 'Rosalind Parker-daughter))
                   ((eq? Downing-daughter 'Gabrielle) 
                    (eq? 'Melissa Parker-daughter))
                   ((eq? Moore-daughter 'Gabrielle)
                    (eq? 'Lorna Parker-daughter))
                   (else false)))
    (require 
     (distinct? 
      (list Moore-daughter Hall-daughter Downing-daughter Parker-daughter)))
    (list (list 'Barnacle Barnacle-daughter)
          (list 'Moore    Moore-daughter)
          (list 'Hall     Hall-daughter)
          (list 'Downing  Downing-daughter)
          (list 'Parker   Parker-daughter))))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(father-daughter)

;;; Starting a new problem 
;;; Amb-Eval value:
((barnacle melissa) (moore mary) (hall gabrielle) (downing lorna) (parker rosalind))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((barnacle melissa) (moore gabrielle) (hall mary) (downing rosalind) (parker lorna))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(father-daughter)
|#