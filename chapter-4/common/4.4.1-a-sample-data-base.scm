;;; 4.4.1 A sample data base
;;; 将Microshaft的人事信息放入数据库

(define (put-into-database data)
  (add-rule-or-assertion! 
   (add-assertion-body 
    (query-syntax-process data))))

(put-into-database '(assert! (address (Bitdiddle Ben) (Slumerville (Ridge Road) 10))))
(put-into-database '(assert! (job (Bitdiddle Ben) (computer wizard))))
(put-into-database '(assert! (salary (Bitdiddle Ben) 60000)))

(put-into-database '(assert! (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))))
(put-into-database '(assert! (job (Hacker Alyssa P) (computer programmer))))
(put-into-database '(assert! (salary (Hacker Alyssa P) 40000)))
(put-into-database '(assert! (supervisor (Hacker Alyssa P) (Bitdiddle Ben))))

(put-into-database '(assert! (address (Fect Cy D) (Cambridge (Ames Street) 3))))
(put-into-database '(assert! (job (Fect Cy D) (computer programmer))))
(put-into-database '(assert! (salary (Fect Cy D) 35000)))
(put-into-database '(assert! (supervisor (Fect Cy D) (Bitdiddle Ben))))

(put-into-database '(assert! (address (Tweakit Lem E) (Boston (Bay State Road) 22))))
(put-into-database '(assert! (job (Tweakit Lem E) (computer technician))))
(put-into-database '(assert! (salary (Tweakit Lem E) 25000)))
(put-into-database '(assert! (supervisor (Tweakit Lem E) (Bitdiddle Ben))))

(put-into-database '(assert! (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))))
(put-into-database '(assert! (job (Reasoner Louis) (computer programmer trainee))))
(put-into-database '(assert! (salary (Reasoner Louis) 30000)))
(put-into-database '(assert! (supervisor (Reasoner Louis) (Hacker Alyssa P))))

(put-into-database '(assert! (supervisor (Bitdiddle Ben) (Warbucks Oliver))))
(put-into-database '(assert! (address (Warbucks Oliver) (Swellesley (Top Heap Road)))))
(put-into-database '(assert! (job (Warbucks Oliver) (administration big wheel))))
(put-into-database '(assert! (salary (Warbucks Oliver) 150000)))

(put-into-database '(assert! (address (Scrooge Eben) (Weston (Shady Lane) 10))))
(put-into-database '(assert! (job (Scrooge Eben) (accounting chief accountant))))
(put-into-database '(assert! (salary (Scrooge Eben) 75000)))
(put-into-database '(assert! (supervisor (Scrooge Eben) (Warbucks Oliver))))

(put-into-database '(assert! (address (Cratchet Robert) (Allston (N Harvard Street) 16))))
(put-into-database '(assert! (job (Cratchet Robert) (accounting scrivener))))
(put-into-database '(assert! (salary (Cratchet Robert) 18000)))
(put-into-database '(assert! (supervisor (Cratchet Robert) (Scrooge Eben))))

(put-into-database '(assert! (address (Aull DeWitt) (Slumerville (Onion Square) 5))))
(put-into-database '(assert! (job (Aull DeWitt) (administration secretary))))
(put-into-database '(assert! (salary (Aull DeWitt) 25000)))
(put-into-database '(assert! (supervisor (Aull DeWitt) (Warbucks Oliver))))

(put-into-database '(assert! (can-do-job (computer wizard) (computer programmer))))
(put-into-database '(assert! (can-do-job (computer wizard) (computer technician))))

(put-into-database '(assert! (can-do-job (computer programmer)
                                         (computer programmer trainee))))

(put-into-database '(assert! (can-do-job (administration secretary)
                                         (administration big wheel))))

(put-into-database '(assert! (rule (same ?x ?x))))