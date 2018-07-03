;;; general-arith.scm

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
(define (raise x) (apply-generic 'raise x))
(define (drop x) (apply-generic 'drop x))
(define (neg x) (apply-generic 'neg x))

;; exercise 2-94添加
(define (greatest-common-divisor x y) (apply-generic 'gcd x y))

;; exercise 2-97-a添加
(define (reduce x y) (apply-generic 'reduce x y))