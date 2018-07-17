;;; 70-b.scm

(load "weighted-pairs.scm")
(load "merge-weighted.scm")
(load "../exercise-3.56/56.scm") ; 引用可以被2，3，5整除的整数流，需要去除首端元素1

;; stream-235为可以被2、3或5整除的整数流
(define stream-235 (stream-cdr S))
;; test
(stream-head stream-235 10) 
;Value: (2 3 4 5 6 8 9 10 12 15)


(define (weight l)
  (define (weight-inner a b)
    (+ (* 2 a)
       (* 3 b)
       (* 5 a b)))
  (apply weight-inner l))
;; test
(weight (list 2 3))
;Value: 43

(define pairs-235
  (weighted-pairs stream-235 stream-235 weight))

;; 打印前10个pair
(display (stream-head pairs-235 10))
(newline)
;结果: ((2 2) (2 3) (2 4) (3 3) (2 5) (3 4) (2 6) (3 5) (4 4) (2 8))

;; 前10个pair对应的 (2i + 3j + 5ij) 值
(map (lambda (x) (weight x))
     (stream-head pairs-235 10))
; 结果: (30 43 56 60 69 78 82 96 100 108)

