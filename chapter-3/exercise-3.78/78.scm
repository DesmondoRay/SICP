;;; 78.scm

(load "../common/scale-stream.scm")
(load "../common/add-streams.scm")
(load "integral-delay.scm")

(define (solve-2nd a b dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (add-streams (scale-stream dy (* a dt)) 
						   (scale-stream y (* b (square dt)))))
  y)

;; test
(stream-ref (solve-2nd 1 1 0.0001 1 1) 10000)
;Value: 2.0000500033321242