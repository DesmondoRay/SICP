;;; exercise 4.57
#|
(assert! (rule (replace ?person-1 ?person-2)
               (and (job ?person-1 ?job-1)
                    (job ?person-2 ?job-2)
                    (or (same ?job-1 ?job-2)
                        (can-do-job ?job-1 ?job-2))
                    (not (same ?person-1 ?person-2)))))

; a)
(replace ?person (Fect Cy D))

; b)
(and (replace ?person-1 ?person-2)
     (salary ?person-1 ?amount-1)
     (salary ?person-2 ?amount-2)
     (lisp-value > ?amount-2 ?amount-1))
|#

;; test
(load "../common/query-system-driver-loop.scm")
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(assert! (rule (replace ?person-1 ?person-2)
               (and (job ?person-1 ?job-1)
                    (job ?person-2 ?job-2)
                    (or (same ?job-1 ?job-2)
                        (can-do-job ?job-1 ?job-2))
                    (not (same ?person-1 ?person-2)))))

Assertion added to data base.

;;; Query input:
(replace ?person (Fect Cy D))

;;; Query results:
(replace (bitdiddle ben) (fect cy d))
(replace (hacker alyssa p) (fect cy d))

;;; Query input:
(and (replace ?person-1 ?person-2)
     (salary ?person-1 ?amount-1)
     (salary ?person-2 ?amount-2)
     (lisp-value > ?amount-2 ?amount-1))

;;; Query results:
(and (replace (aull dewitt) (warbucks oliver)) 
     (salary (aull dewitt) 25000) 
     (salary (warbucks oliver) 150000) 
     (lisp-value > 150000 25000))
(and (replace (fect cy d) (hacker alyssa p)) 
     (salary (fect cy d) 35000) 
     (salary (hacker alyssa p) 40000) 
     (lisp-value > 40000 35000))
|#