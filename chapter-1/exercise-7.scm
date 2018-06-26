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

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (square a) (* a a))

(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))

(sqrt 0.001)
(sqrt 423840238402365654654737243543265346456457345665476576586458567546345635454)