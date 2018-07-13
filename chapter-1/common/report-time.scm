;;; report-time.scm

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