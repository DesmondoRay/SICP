(load "p3-make-rect-2.scm")

(define (perimeter rect)
  (* 2 (+ (length-of-rect rect)
          (width-of-rect rect))))

(define (area rect)
  (* (length-of-rect rect)
     (width-of-rect rect)))

;; test:
(define rectangle (make-rect 10 10))

(newline)
(display (perimeter rectangle))
(newline)
(display (area rectangle))

#| output: 
40
100
|#