;;; exercise 1.3

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (sum-of-two-max x y z)
  (+ (max x y)
     (max (min x y) z)))

(sum-of-two-max 5 1 8)