;;; exercise 4.69

(load "../common/query-system-driver-loop.scm")

(query-driver-loop)

(assert! (son Adam Cain))
(assert! (son Cain Enoch))
(assert! (son Enoch Irad))
(assert! (son Irad Mehujael))
(assert! (son Mehujael Methushael))
(assert! (son Methushael Lamech))
(assert! (wife Lamech Ada))
(assert! (son Ada Jabal))
(assert! (son Ada Jubal))

(assert! (rule (grandson ?person-1 ?person-2)
               (and (son ?person-1 ?person)
                    (son ?person ?person-2))))

(assert! (rule (son ?person-1 ?person-2)
               (and (wife ?person-1 ?person)
                    (son ?person ?person-2))))

(assert! (rule (end-in-grandson (grandson))))

(assert! (rule (end-in-grandson (?x . ?rest))
               (end-in-grandson ?rest)))

(assert! (rule ((grandson) ?x ?y)
               (grandson ?x ?y)))

(assert! (rule ((great . ?rel) ?x ?y)
               (and (end-in-grandson ?rel)
                    (son ?x ?z)
                    (?rel ?z ?y))))

#|
测试结果
;;; Query input:
((great grandson) Adam ?x)

;;; Query results:
((great grandson) adam irad)

;;; Query input:
(?relationship Adam Irad)

;;; Query results:
;... aborted
;Aborting!: maximum recursion depth exceeded
|#