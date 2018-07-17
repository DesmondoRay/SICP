;;; 70-a.scm

(load "weighted-pairs.scm")
(load "merge-weighted.scm")

;; test
(load "../common/integers.scm")

(define (weight l)
  (+ (car l) (cadr l)))

(define weighted-stream 
  (weighted-pairs integers integers weight))
(stream-head weighted-stream 30)
; 结果: 
;   ((1 1) (1 2) (1 3) (2 2) (1 4) (2 3) (1 5) (2 4) (3 3) (1 6) 
;   (2 5) (3 4) (1 7) (2 6) (3 5) (4 4) (1 8) (2 7) (3 6) (4 5)
;   (1 9) (2 8) (3 7) (4 6) (5 5) (1 10) (2 9) (3 8) (4 7) (5 6))

