(define (make-vect x y)
  (cons x y))

(define (xcor-rect v)
  (car v))

(define (ycor-rect v)
  (car (cdr v)))

(define (add-rect v1 v2)
  (make-rect (+ (xcor-rect v1)
                (xcor-rect v2))
             (+ (ycor-rect v1)
                (ycor-rect v2))))

(define (sub-rect v1 v2)
  (make-rect (- (xcor-rect v1)
                (xcor-rect v2))
             (- (ycor-rect v1)
                (ycor-rect v2))))

(define (scale-rect factor vect)
    (make-vect (* factor (xcor-vect vect))
               (* factor (ycor-vect vect))))