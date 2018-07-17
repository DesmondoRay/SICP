;;; 82.scm

;; 范围内的随机数，b > a
(define (random-range a b)
  (cons-stream (+ a
                  (/ (random (* 1000 (- b a))) 
                     1000))
               (random-range a b)))
;; test: random-range
; (display (stream-head (random-range 2.0 8) 10))
#| output: 
(3.9216451508502788 4.872171308887505 7.349624890899868 
 6.027717480060917 7.332440648705427 3.4968967913431355 
 2.2747132940402044 4.253778629824832 6.007124983245536 2.4848337362173623)
|#


;; 生成测试结果的流
(define (p-test x1 x2 y1 y2)
  (let ((x-stream (random-range x1 x2))
        (y-stream (random-range y1 y2))
        (avg-x (/ (+ x2 x1) 2))
        (avg-y (/ (+ y2 y1) 2))
        (radius (/ (- x2 x1) 2)))
    (stream-map (lambda (x y) (<= (+ (square (- x avg-x))
                                     (square (- y avg-y)))
                                  (square radius)))
                x-stream y-stream)))
; test: p-test
; (define test-result (p-test 2.0 8 4 10))
; (display (stream-head test-result 10))
; output: (#t #t #t #t #t #t #t #t #t #t)


;; page 246
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed (+ passed failed))
                 (monte-carlo 
                  (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))
; test: monte-carlo
; (define test-result (p-test 2.0 8 4 10))
; (define monte (monte-carlo test-result 0 0))
; (display (stream-head monte 10))
; output: (0 0 1/3 1/2 3/5 2/3 5/7 3/4 2/3 7/10)


;; 蒙特卡罗积分 estimate-integral
;; 假定 x2 > x1, y2 > y1
(define (estimate-integral p x1 x2 y1 y2)
  (stream-map (lambda (n) (* n (* (- x2 x1) (- y2 y1))))
              (monte-carlo (p x1 x2 y1 y2) 0 0)))
; test: estimate-integral
; (define estimate (estimate-integral p-test 2.0 8 4 10))
; (display (stream-head estimate 10))
; output: (0 18. 24. 27. 21.599999999999998 18. 20.57142857142857 18. 16. 18.)


;; 计算pi值
(define estimate-pi
  (stream-map (lambda (n) (/ n 900))
              (estimate-integral p-test 20.0 80 40 100)))


;; test
(load "../common/print.scm")
(print
 (stream-ref estimate-pi 10)
 (stream-ref estimate-pi 100)
 (stream-ref estimate-pi 1000)
 (stream-ref estimate-pi 10000)
 (stream-ref estimate-pi 100000))
#| output:
2.5454545454545454
3.4455445544554455
3.096903096903097
3.116088391160884
3.1401285987140124
|#
