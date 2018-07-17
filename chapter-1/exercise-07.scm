;;; exercise 1.7

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      (improve guess x)
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
   (< (/ (abs (- (improve guess x) guess)) guess) 0.001))

(define (sqrt-e7 x)
  (sqrt-iter 1.0 x))

;; test
(newline)
(display (sqrt-e7 9))
(newline)
(display (sqrt-e7 (+ 100 37)))
(newline)
(display (sqrt-e7 (+ (sqrt-e7 2) (sqrt-e7 3))))
(newline)
(display (square (sqrt-e7 1000)))
(newline)
(display (sqrt-e7 0.001))
(newline)
(display 
 (sqrt-e7 423840238402365654654737243543265545446445454545451646131464897897))
(newline)
#| 结果:
    3.000000001396984
    11.704699917758145
    1.7737712336472033
    1000.000369924366
    .03162278245070105
    6.51030290207671e32
|#

;; 使用scheme内置的sqrt测试:
(newline)
(display (sqrt 9))
(newline)
(display (sqrt (+ 100 37)))
(newline)
(display (sqrt (+ (sqrt 2) (sqrt 3))))
(newline)
(display (square (sqrt 1000)))
(newline)
(display (sqrt 0.001))
(newline)
(display 
 (sqrt 423840238402365654654737243543265545446445454545451646131464897897))
(newline)
#| 结果:
    3
    11.704699910719626
    1.7737712281864233
    1000.
    .03162277660168379
    6.510301363242455e32
|#


