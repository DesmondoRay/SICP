(load "../Exercise-2.08/p8.scm")

(define (width x)
  (/ (- (upper-bound x) (lower-bound x))
     2))

(define interval-1 (make-interval 1 2))
(define interval-2 (make-interval 3 4))

(define add (add-interval interval-1 interval-2))

(define sub (sub-interval interval-1 interval-2))

(define mul (mul-interval interval-1 interval-2))

(define div (div-interval interval-1 interval-2))

;; test
(newline)
(display (width add))
(newline)
(display (width sub))
(newline)
(display (width mul))
(newline)
(display (width div))

#| output:
1
1
5/2
.20833333333333331
|#