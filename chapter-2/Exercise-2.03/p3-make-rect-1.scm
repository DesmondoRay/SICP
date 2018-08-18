(define make-rect cons)
(define start-rect car)
(define end-rect cdr)

(define make-point cons)
(define x-point car)
(define y-point cdr)

(define (length-of-rect rect)
  (abs (- (x-point(start-rect rect))
          (x-point(end-rect rect)))))

(define (width-of-rect rect)
  (abs (- (y-point(start-rect rect))
          (y-point(end-rect rect)))))