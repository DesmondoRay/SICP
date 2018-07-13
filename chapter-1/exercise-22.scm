;;; exercise 1.22

(load "common/prime?.scm")

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))

(define (report-prime n elapsed-time)
  (display n)
  (newline))

(define (search-for-primes n counts start-time)
  (timed-prime-test n)
  (if (= 0 counts)
      (display-time start-time)
      (if (prime? n)
          (search-for-primes (+ n 1) (- counts 1) start-time)
          (search-for-primes (+ n 1) counts start-time))))

(define (display-time start-time)
  (report-time (- (runtime) start-time)))

(define (report-time time)
  (display "time: ")
  (display (* 1000 time))  ; ms
  (newline))

;; test
(search-for-primes 1000000000 3 (runtime))
(newline)
(search-for-primes 10000000000 3 (runtime))
(newline)
(search-for-primes 100000000000 3 (runtime))
(newline)
#|
输出：
1000000007
1000000009
1000000021
time: 149.99999999999946

10000000019
10000000033
10000000061
time: 500.

100000000003
100000000019
100000000057
time: 1410.0000000000002
|#
;; 消耗时间的增长率约为3，接近于(sqrt 10)
