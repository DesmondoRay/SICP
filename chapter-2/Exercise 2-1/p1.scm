(define (make-rat n d)
  (if (or (and (< n 0) (< d 0)) (and (< d 0) (> n 0)))
      (make-rat (- 0 n) (- 0 d))
      (let ((g (gcd n d)))
        (cons (/ n g) (/ d g)))))

(define numer car)

(define denom cdr)

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 1 2))
(print-rat (make-rat -1 2))
(print-rat (make-rat 1 -2))
(print-rat (make-rat -1 -2))