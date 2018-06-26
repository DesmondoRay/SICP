;;; exercise 1.3

(define (square a) (* a a))

(define (sum-of-squares a b)
  (+ (square a) (square b)))

(define (max a b)
  (if (> a b)
      a
      b))

(define (sum-of-two-squares x y z)
  (sum-of-squares (max x y)
                 (max (max x y) z)))

(sum-of-two-squares 5 1 8)

#! other define !#
(define (>= a b)
  (or (> a b) (= a b)))

(define (sum-squares x y z)
  (cond ((and (>= x z) (>= y z))
         (+ (* x x) (* y y)))
        ((and (>= x y) (>= z y))
         (+ (* x x) (* z z)))
        (else (+ (* y y) (* z z)))))

(sum-squares 5 1 8)