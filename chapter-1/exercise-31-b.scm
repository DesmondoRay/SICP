;;; exercise 1.31 b

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (inc a) (+ a 1))
(define (term a) a)
(define (term-double a) (* 2 a))

(define (factorial a b)
  (product term a inc b))

(define (factorial-double a b)
  (product term-double a inc b))

(define (square a) (* a a))

(define (numerator n)
  (if (even? n)
      (* (factorial-double 1 (/ n 2))
         (factorial-double 2 (+ 1(/ n 2))))
      (* (numerator (- n 1))
         (+ n 1))))

(define (denominator n)
  (if (even? n)
      (square (/ (factorial 1 (+ 1 n)) (factorial-double 1 (/ n 2))))
      (* (denominator (- n 1))
         (+ n 2))))

(define (compute n)
  (exact->inexact(/ (numerator n)
     (denominator n))))

(* (compute 100) 4)
(* (compute 1000) 4)
