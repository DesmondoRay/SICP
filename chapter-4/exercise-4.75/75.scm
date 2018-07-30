;;; exercise 4.75

(load "../common/query-system-driver-loop.scm")

(define (unique-query exps) (car exps))

(define (uniquely-asserted operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (let ((result (qeval (unique-query operands)
                          (singleton-stream frame))))
       (if (and (not (stream-null? result))
                (stream-null? (stream-cdr result)))
           result
           the-empty-stream)))
     frame-stream))
(put 'unique 'qeval uniquely-asserted)


;; test
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(unique (job ?x (computer wizard)))

;;; Query results:
(unique (job (bitdiddle ben) (computer wizard)))

;;; Query input:
(unique (job ?x (computer programmer)))

;;; Query results:

;;; Query input:
(and (job ?x ?j) (unique (job ?anyone ?j)))

;;; Query results:
(and (job (aull dewitt) (administration secretary)) (unique (job (aull dewitt) (administration secretary))))
(and (job (cratchet robert) (accounting scrivener)) (unique (job (cratchet robert) (accounting scrivener))))
(and (job (scrooge eben) (accounting chief accountant)) (unique (job (scrooge eben) (accounting chief accountant))))
(and (job (warbucks oliver) (administration big wheel)) (unique (job (warbucks oliver) (administration big wheel))))
(and (job (reasoner louis) (computer programmer trainee)) (unique (job (reasoner louis) (computer programmer trainee))))
(and (job (tweakit lem e) (computer technician)) (unique (job (tweakit lem e) (computer technician))))
(and (job (bitdiddle ben) (computer wizard)) (unique (job (bitdiddle ben) (computer wizard))))
|#
