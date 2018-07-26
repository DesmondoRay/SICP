;;; exercise 4.62
#|
(assert! (rule (last-pair (?x) (?x))))

(assert! (rule (last-pair (?u . ?v) (?x))
               (last-pair ?v (?x))))
|#

;; test
(load "../common/query-system-driver-loop.scm")
(query-driver-loop)
#|
;;; Query input:
(assert! (rule (last-pair (?x) (?x))))

Assertion added to data base.

;;; Query input:
(assert! (rule (last-pair (?u . ?v) (?x))
               (last-pair ?v (?x))))

Assertion added to data base.

;;; Query input:
(last-pair (3) ?x)

;;; Query results:
(last-pair (3) (3))

;;; Query input:
(last-pair (1 2 3) ?x)

;;; Query results:
(last-pair (1 2 3) (3))

;;; Query input:
(last-pair (2 ?x) (3))

;;; Query results:
(last-pair (2 3) (3))

;;; Query input:
(last-pair ?x (3))

;;; Query results:  ; 无输出，因为有无数个解
|#