(load "p3-make-rect-1.scm")

(define (perimeter rect)
  (* 2 (+ (length-of-rect rect)
          (width-of-rect rect))))

(define (area rect)
  (* (length-of-rect rect)
     (width-of-rect rect)))

(define start (make-point 10 10))
(define end (make-point 20 20))
(define rectangle (make-rect start end))

(newline)
(display (perimeter rectangle))
(newline)
(display (area rectangle))