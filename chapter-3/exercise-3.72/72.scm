;;; 72.scm

(load "../exercise-3.70/merge-weighted.scm")
(load "../exercise-3.70/weighted-pairs.scm")

;; 定义权重函数
(define (weight-sum-square l)
  (+ (square (car l))
     (square (cadr l))))
;; test weight-sum-square
(weight-sum-square (list 2 3))
;Value: 35

;; 生成平方和的流
(load "../common/integers.scm")
(define square-stream
  (weighted-pairs integers integers weight-sum-square))
;; test square-stream
(display (stream-head square-stream 10))
; 结果: ((1 1) (1 2) (2 2) (1 3) (2 3) (1 4) (3 3) (2 4) (3 4) (1 5))
(newline)
(display (map (lambda (x) (weight-sum-square x))
              (stream-head square-stream 10)))
; 结果: (2 5 8 10 13 17 18 20 25 26)
(newline)


;; 寻找具有同样权重的三个相邻的序对
(define (find-3-same-weight rest first second)
  (if (= (weight-sum-square first)
         (weight-sum-square second)
         (weight-sum-square (stream-car rest)))
      (cons-stream (list first second (stream-car rest))
                   (find-3-same-weight (stream-cdr (stream-cdr rest))
                                       (stream-car rest)
                                       (stream-car (stream-cdr rest))))
      (find-3-same-weight (stream-cdr (stream-cdr rest))
                          (stream-car rest)
                          (stream-car (stream-cdr rest)))))

;; 生成具有同样权重的三个相邻的序对
(define three-same-weight
  (find-3-same-weight (stream-cdr (stream-cdr square-stream))
                      (stream-car square-stream)
                      (stream-car (stream-cdr square-stream))))

;; 测试
(newline)
(define top-5 (stream-head three-same-weight 5))
(display top-5)
; 结果: 
;   (((5 25) (11 23) (17 19)) 
;    ((1 32) (8 31) (20 25)) 
;    ((9 32) (12 31) (23 24)) 
;    ((5 35) (17 31) (25 25)) 
;    ((2 36) (12 34) (20 30)))
(newline)
(display (map (lambda (x)
                (map (lambda (y) (weight-sum-square y))
                     x))
              top-5))
; 结果: 
;   ((650 650 650) 
;    (1025 1025 1025) 
;    (1105 1105 1105) 
;    (1250 1250 1250) 
;    (1300 1300 1300))

