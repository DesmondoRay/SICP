(load "../Exercise-2.12/p12.scm")

(define (mul-percent a)
  (lower-bound a))

(define i (make-center-percent 100 0.01))
(define j (make-center-percent 50 0.01))

(define k (mul-interval i j))

;; test
(display (percent k))

;; output: 1.9998000199980003e-2