;;; exercise 1.23

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (prime? n)
  (= n (smallest-divisor n)))


;; test
(load "common/report-time.scm")
(search-for-primes 1000000000 3 (runtime))
(newline)
(search-for-primes 10000000000 3 (runtime))
(newline)
(search-for-primes 100000000000 3 (runtime))
(newline)
#| 输出：
1000000007
1000000009
1000000021
time: 89.99999999999986

10000000019
10000000033
10000000061
time: 310.0000000000005

100000000003
100000000019
100000000057
time: 890.0000000000006
|#

;; 不是练习1.22中消耗时间的一半，大约为60%左右
