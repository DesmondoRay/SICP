;;; 77.scm

(define (integral integrand initial-value dt)
  (cons-stream initial-value
               (let ((force-integrand (force integrand))) ; 修改
                 (if (stream-null? force-integrand)
                     the-empty-stream
                     (integral (delay (stream-cdr force-integrand))  ; 修改
                               (+ (* dt (stream-car force-integrand))
                                  initial-value)
                               dt)))))

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;; test
(stream-ref (solve (lambda (y) y) 1 0.001) 1000)
;Value: 2.716923932235896