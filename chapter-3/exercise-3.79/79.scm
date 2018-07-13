;;; 79.scm

(load "../common/scale-stream.scm")
(load "../common/add-streams.scm")
(load "../exercise-3.78/integral-delay.scm")

(define (general-solve-2nd f dt y0 dy0)
  (define dy (integral (delay ddy) dy0 dt))
  (define y  (integral (delay dy) y0 dt))
  (define ddy
	(scale-stream
	 (stream-map f (scale-stream dy (/ 1 dt)) y)
	 (square dt)))
  y)

;; test
(define f 
  (lambda (dy/dt y)
    (+ dy/dt y)))

(stream-ref (solve-gnd f 0.0001 1 1) 10000)
;Value: 2.0000500033321242