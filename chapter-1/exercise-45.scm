;;; exercise 1.45

(load "exercise-43.scm")
(load "exercise-45-fixed-point.scm")
(load "common/average-damp.scm")

(define (nth-root n)
  (lambda (x) (fixed-point (repeat-average-damp(lambda (y)
                                                 (/ x (fast-expt y (- n 1))))
                                               (log-base-2 n))
                           1.0)))

(define (fast-expt y n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt y (/ n 2))))
        (else (* y (fast-expt y (- n 1))))))

(define (repeat-average-damp f n)
  ((repeated average-damp n) f))

(define (log-base-2 n)
  (cond ((> (/ n 2) 1)
         (1+ (log-base-2 (/ n 2))))
        ((< (/ n 2) 1)
         0)
        (else 1)))


;; test
(display ((nth-root 4) 16))
(newline)
(display ((nth-root 8) 256))
(newline)
(display ((nth-root 16) (* 256 256)))
(newline)

#| output:
2.0000000000021965
2.000000000003967
2.000000000076957
|#