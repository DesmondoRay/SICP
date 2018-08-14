;;; exercise 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x) (* x x x))

(define (Simpson f a b n)
  (comp-simpson f a b n 0))

(define (comp-simpson f a b n k)
  (define h (/ (- b a) n))
  (define (yk k)
    (f (+ a (* k h))))
  (define (inc k) (+ 1 k))
  (define (func k)
    (cond ((or (= k 0) (= k n)) (yk k))
          ((even? k) (* 2 (yk k)))
          (else (* 4 (yk k)))))
  (* (/ h 3) (sum func k inc n)))


#| test
1 ]=> (Simpson cube 0.0 1.0 100)

;Value: .24999999999999992

1 ]=> (Simpson cube 0.0 1.0 1000)

;Value: .2500000000000003
|#