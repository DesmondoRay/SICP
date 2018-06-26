;;; exercise 1.22

(define (square a) (* a a))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? test-divisor n)
  (= (remainder n test-divisor) 0))

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

#! ************************* !#

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
  (display time)
  (newline))

(search-for-primes 10000000 3 (runtime))
(newline)
(search-for-primes 100000000 3 (runtime))
(newline)
(search-for-primes 1000000000 3 (runtime))
(newline)












  