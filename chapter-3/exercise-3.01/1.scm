;;; 3.1.scm

(define (make-accumulator sum)
  (lambda (number)
    (begin (set! sum (+ sum number))
           sum)))

;; test
(define A (make-accumulator 5))
(newline)
(display (A 10))
(newline)
(display (A 10))

;; 结果:
;  15
;  25