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

(define (square a) (* a a))

;;; *************************
(define (search-for-primes n counts start-time)
  (if (= 0 counts)
      (if (fast-prime? n counts)
          (search-for-primes (+ n 1) (- counts 1) start-time)
          (search-for-primes (+ n 1) counts start-time))))

(search-for-primes 10000000 3 (runtime))
(newline)
(search-for-primes 100000000 3 (runtime))
(newline)
(search-for-primes 1000000000 3 (runtime))
(newline)