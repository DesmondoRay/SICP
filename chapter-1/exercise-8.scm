;;; exercise 1.8

(define (cube-iter guess x)
  (if (good-enough? guess x)
      (improve guess x)
      (cube-iter (improve guess x)
                 x)))

(define (good-enough? guess x)
  (< (/ (abs (- (improve guess x) guess))
        guess)
     0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess))
        (* 2 guess))
     3))

(define (cube x)
  (cube-iter 1.0 x))

(cube 8)
(cube 27)
(cube 0.001)
(cube 0.0000004)
(cube 58531028402384013928409123850923840923850239850923840923850328203) 