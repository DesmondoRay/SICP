;;; 71.scm

(load "../exercise-3.70/merge-weighted.scm")
(load "../exercise-3.70/weighted-pairs.scm")

;; 定义权重函数
(define (weight-sum-cube l)
  (+ (expt (car l) 3)
	 (expt (cadr l) 3)))
;; test weight-sum-cube
(weight-sum-cube (list 2 3))
;Value: 35

;; 生成立方和的流
(load "../common/integers.scm")
(define cube-stream
  (weighted-pairs integers integers weight-sum-cube))
;; test cube-stream
(display (stream-head cube-stream 10))
; 结果: ((1 1) (1 2) (2 2) (1 3) (2 3) (3 3) (1 4) (2 4) (3 4) (1 5))
(newline)
(display (map (lambda (x) (weight-sum-cube x))
			  (stream-head cube-stream 10)))
; 结果: (2 9 16 28 35 54 65 72 91 126)
(newline)

;; 查找ramanujan数
(define (find-ramanujan rest-pairs first-pair)
  (if (= (weight-sum-cube first-pair)
		 (weight-sum-cube (stream-car rest-pairs)))
	  (cons-stream first-pair
				   (find-ramanujan (stream-cdr rest-pairs)
								   (stream-car rest-pairs)))
	  (find-ramanujan (stream-cdr rest-pairs)
					  (stream-car rest-pairs))))

;; 生成ramanujan数
(define ramanujan-number
  (find-ramanujan (stream-cdr cube-stream)
				  (stream-car cube-stream)))

;; test ramanujan-number
(newline)
(display (stream-head ramanujan-number 5))
; 结果: ((1 12) (2 16) (2 24) (10 27) (4 32))
(newline)
(display (map (lambda (x) (weight-sum-cube x))
			  (stream-head ramanujan-number 5)))
; 结果: (1729 4104 13832 20683 32832)

