;;; exercise 4.56
#|
; a)
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

; b)
(and (salary (Bitdiddle Ben) ?Ben-amount) 
     (salary ?person ?amount) 
     (lisp-value < ?amount ?Ben-amount))

; c)
(and (supervisor ?person ?super)
     (job ?person ?job)
     (not (job ?super (computer . ?work))))
|#

;; test
(load "../common/query-system-driver-loop.scm")
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

;;; Query results:
(and (supervisor (tweakit lem e) (bitdiddle ben)) 
     (address (tweakit lem e) (boston (bay state road) 22)))
(and (supervisor (fect cy d) (bitdiddle ben)) 
     (address (fect cy d) (cambridge (ames street) 3)))
(and (supervisor (hacker alyssa p) (bitdiddle ben)) 
     (address (hacker alyssa p) (cambridge (mass ave) 78)))

;;; Query input:
(and (salary (Bitdiddle Ben) ?Ben-amount) 
     (salary ?person ?amount) 
     (lisp-value < ?amount ?Ben-amount))

;;; Query results:
(and (salary (bitdiddle ben) 60000) 
     (salary (aull dewitt) 25000) 
     (lisp-value < 25000 60000))
(and (salary (bitdiddle ben) 60000) 
     (salary (cratchet robert) 18000) 
     (lisp-value < 18000 60000))
(and (salary (bitdiddle ben) 60000) 
     (salary (reasoner louis) 30000) 
     (lisp-value < 30000 60000))
(and (salary (bitdiddle ben) 60000) 
     (salary (tweakit lem e) 25000) 
     (lisp-value < 25000 60000))
(and (salary (bitdiddle ben) 60000) 
     (salary (fect cy d) 35000) 
     (lisp-value < 35000 60000))
(and (salary (bitdiddle ben) 60000) 
     (salary (hacker alyssa p) 40000) 
     (lisp-value < 40000 60000))

;;; Query input:
(and (supervisor ?person ?super)
     (job ?person ?job)
     (not (job ?super (computer . ?work))))

;;; Query results:
(and (supervisor (aull dewitt) (warbucks oliver)) 
     (job (aull dewitt) (administration secretary)) 
     (not (job (warbucks oliver) (computer . ?work))))
(and (supervisor (cratchet robert) (scrooge eben)) 
     (job (cratchet robert) (accounting scrivener)) 
     (not (job (scrooge eben) (computer . ?work))))
(and (supervisor (scrooge eben) (warbucks oliver)) 
     (job (scrooge eben) (accounting chief accountant)) 
     (not (job (warbucks oliver) (computer . ?work))))
(and (supervisor (bitdiddle ben) (warbucks oliver)) 
     (job (bitdiddle ben) (computer wizard)) 
     (not (job (warbucks oliver) (computer . ?work))))
|#