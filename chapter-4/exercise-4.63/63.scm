;;; exercise 4.63
#|
(assert! (rule (grandson ?person-1 ?person-2)
               (and (son ?person-1 ?person)
                    (son ?person ?person-2))))

(assert! (rule (son ?person-1 ?person-2)
               (and (wife ?person-1 ?person)
                    (son ?person ?person-2))))
|#

;; test
(load "../common/query-system-driver-loop.scm")

(query-driver-loop)
#|
;;; Query input:
(assert! (son Adam Cain))
(assert! (son Cain Enoch))
(assert! (son Enoch Irad))
(assert! (son Irad Mehujael))
(assert! (son Mehujael Methushael))
(assert! (son Methushael Lamech))
(assert! (wife Lamech Ada))
(assert! (son Ada Jabal))
(assert! (son Ada Jubal))
Assertion added to data base.

;;; Query input:

Assertion added to data base.
......

;;; Query input:
(assert! (rule (grandson ?person-1 ?person-2)
               (and (son ?person-1 ?person)
                    (son ?person ?person-2))))
Assertion added to data base.

;;; Query input:

Assertion added to data base.

;;; Query input:
(assert! (rule (son ?person-1 ?person-2)
               (and (wife ?person-1 ?person)
                    (son ?person ?person-2))))

Assertion added to data base.

;;; Query input:
(grandson Cain ?x)

;;; Query results:
(grandson cain irad)

;;; Query input:
(son Lamech ?x)

;;; Query results:
(son lamech jubal)
(son lamech jabal)

;;; Query input:
(grandson Methushael ?x)

;;; Query results:
(grandson methushael jubal)
(grandson methushael jabal)
|#