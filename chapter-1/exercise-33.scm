;;; exercise 1.33

(load "prime?.scm")

(define (accumulate combiner null-value filter term a next b)
  (cond ((> a b) null-value)
        ((filter (term a))
         (combiner (term a)
                   (accumulate combiner null-value filter term (next a) next b)))
        (else (accumulate combiner null-value filter term (next a) next b))))

(define (sum-primes a b)
  (define (term a) a)
  (define (inc a) (+ 1 a))
  (accumulate + 0 prime? term a inc b))

(define (sum-gcd n)
  (define (term a) a)
  (define (inc a) (+ 1 a))
  (define (gcd? a)
    (= 1 (gcd a n)))
  (define (gcd a n)
    (if (= n 0)
        a
        (gcd n (remainder a n))))
  (accumulate * 1 gcd? term 1 inc n))

(sum-primes 2 10)
(sum-gcd 10)
