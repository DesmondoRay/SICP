;;; exercise 1.24

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n) (fast-prime? n 10))


;; test
(load "common/report-time.scm")
(search-for-primes (square 1000000000) 3 (runtime))
(newline)
(search-for-primes (square 10000000000) 3 (runtime))
(newline)
(search-for-primes (square 100000000000) 3 (runtime))
(newline)
#| 输出:
1000000000000000003
1000000000000000009
1000000000000000031
time: 19.999999999999574

10000000000000000000009
10000000000000000000057
10000000000000000000081
time: 30.000000000001137

100000000000000000000000067
100000000000000000000000123
100000000000000000000000127
time: 50.00000000000071
|#
; 注： 数字太小不足以得出准确的时间
