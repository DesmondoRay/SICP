;;; exercise 4.61

(load "../common/query-system-driver-loop.scm")

(query-driver-loop)
#|
;;; Query input:
(assert! (rule (?x next-to ?y in (?x ?y . ?u))))

Assertion added to data base.

;;; Query input:
(assert! (rule (?x next-to ?y in (?v . ?z))
               (?x next-to ?y in ?z)))

Assertion added to data base.

;;; Query input:
(?x next-to ?y in (1 (2 3) 4))

;;; Query results:
((2 3) next-to 4 in (1 (2 3) 4))
(1 next-to (2 3) in (1 (2 3) 4))

;;; Query input:
(?x next-to 1 in (2 1 3 1))

;;; Query results:
(3 next-to 1 in (2 1 3 1))
(2 next-to 1 in (2 1 3 1))
|#