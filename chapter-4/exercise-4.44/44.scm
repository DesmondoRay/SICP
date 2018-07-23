;;; exercise 4.44

(define (queens)
  (let ((lst0 '())
        (row1 (cons 1 (amb 1 2 3 4 5 6 7 8))))
    (let ((lst1 (cons row1 lst0))
          (row2 (cons 2 (amb 1 2 3 4 5 6 7 8))))
      (require (safe row2 lst1))
      (let ((lst2 (cons row2 lst1))
            (row3 (cons 3 (amb 1 2 3 4 5 6 7 8))))
        (require (safe row3 lst2))
        (let ((lst3 (cons row3 lst2))
              (row4 (cons 4 (amb 1 2 3 4 5 6 7 8))))
          (require (safe row4 lst3))
          (let ((lst4 (cons row4 lst3))
                (row5 (cons 5 (amb 1 2 3 4 5 6 7 8))))
            (require (safe row5 lst4))
            (let ((lst5 (cons row5 lst4))
                  (row6 (cons 6 (amb 1 2 3 4 5 6 7 8))))
              (require (safe row6 lst5))
              (let ((lst6 (cons row6 lst5))
                    (row7 (cons 7 (amb 1 2 3 4 5 6 7 8))))
                (require (safe row7 lst6))
                (let ((lst7 (cons row7 lst6))
                      (row8 (cons 8 (amb 1 2 3 4 5 6 7 8))))
                  (require (safe row8 lst7))
                  (cons row8 lst7))))))))))

;; 判断在x位置放入一个皇后，是否安全
(define (safe x lst)
  ; 不在同一列
  (define (not-in-same-col x lst)
    (if (null? lst)
        true
        (if (not (= (cdr x) (cdr (car lst))))
            (not-in-same-col x (cdr lst))
            false)))
  ; 不在对角线
  (define (not-diagonal x lst)
    (if (null? lst)
        true
        (if (not (= (abs (- (cdr x) (cdr (car lst))))
                    (abs (- (car x) (car (car lst))))))
            (not-diagonal x (cdr lst))
            false)))
  (if (not-in-same-col x lst)
      (not-diagonal x lst)
      false))

;; test
(load "../common/amb-evaluator.scm")

(driver-loop)
;;; Amb-Eval input:
(queens)
#|
;;; Starting a new problem 
;;; Amb-Eval value:
((8 . 4) (7 . 2) (6 . 7) (5 . 3) (4 . 6) (3 . 8) (2 . 5) (1 . 1))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((8 . 5) (7 . 2) (6 . 4) (5 . 7) (4 . 3) (3 . 8) (2 . 6) (1 . 1))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((8 . 3) (7 . 5) (6 . 2) (5 . 8) (4 . 6) (3 . 4) (2 . 7) (1 . 1))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
((8 . 3) (7 . 6) (6 . 4) (5 . 2) (4 . 8) (3 . 5) (2 . 7) (1 . 1))
|#