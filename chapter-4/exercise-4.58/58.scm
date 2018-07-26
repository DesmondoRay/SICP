;;; exercise 4.58
#|
(assert! 
 (rule (big-shot ?person ?division)
       (and (job ?person (?division . ?work))
            (and (supervisor ?person ?boss)   ; 上级不在本部门
                 (not (job ?boss (?division . ?rest)))))))
|#

;; test
(load "../common/query-system-driver-loop.scm")
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(big-shot ?person computer)

;;; Query results:
(big-shot (bitdiddle ben) computer)

;;; Query input:
(big-shot ?person accounting)

;;; Query results:
(big-shot (scrooge eben) accounting)
|#