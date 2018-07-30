;;; exercise 4.68

(load "../common/query-system-driver-loop.scm")

(add-rule-or-assertion! 
   (add-assertion-body 
    (query-syntax-process
     '(assert! (rule (append-to-form () ?y ?y))))))

(add-rule-or-assertion! 
   (add-assertion-body 
    (query-syntax-process
     '(assert! (rule (append-to-form (?u . ?v) ?y (?u . ?z))
                     (append-to-form ?v ?y ?z))))))

(query-driver-loop)
#| 
;;; Query input:
(assert! (rule (reverse (?x) (?x))))
(assert! (rule (reverse (?u . ?v) ?w)
               (and (append-to-form ?z (?u) ?w)  ; difference
                    (reverse ?v ?z))))           ; difference
Assertion added to data base.

;;; Query input:

Assertion added to data base.

;;; Query input:
(reverse ?x (1 2 3))  ; difference

;;; Query results:
(reverse (3 2 1) (1 2 3))

;;; Query input:
(reverse (1 2 3) ?x)  ; difference

;;; Query results: ; 无限循环
|#

#|
;;; Query input:
(assert! (rule (reverse (?x) (?x))))
(assert! (rule (reverse (?u . ?v) ?w)
               (and (reverse ?v ?z)                 ; difference
                    (append-to-form ?z (?u) ?w))))  ; difference
Assertion added to data base.

;;; Query input:


Assertion added to data base.

;;; Query input:
(reverse (1 2 3) ?x)  ; difference

;;; Query results:
(reverse (1 2 3) (3 2 1))

;;; Query input:
(reverse ?x (1 2 3))  ; difference

;;; Query results: ; 无限循环
|#
                    