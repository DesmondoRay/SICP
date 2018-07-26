;;; exercise 4.55
#|
; a)
(supervisor ?x (Bitdiddle Ben))

; b)
(job ?x (accounting . ?y))

; c)
(address ?x (Slumerville . ?y))
|#

;; test
(load "../common/query-system-driver-loop.scm")
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(supervisor ?x (Bitdiddle Ben))

;;; Query results:
(supervisor (tweakit lem e) (bitdiddle ben))
(supervisor (fect cy d) (bitdiddle ben))
(supervisor (hacker alyssa p) (bitdiddle ben))

;;; Query input:
(job ?x (accounting . ?y))

;;; Query results:
(job (cratchet robert) (accounting scrivener))
(job (scrooge eben) (accounting chief accountant))

;;; Query input:
(address ?x (Slumerville . ?y))

;;; Query results:
(address (aull dewitt) (slumerville (onion square) 5))
(address (reasoner louis) (slumerville (pine tree road) 80))
(address (bitdiddle ben) (slumerville (ridge road) 10))
|#