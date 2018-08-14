;;; exercise 1.34

(define (f g)
  (g 2))

#| test:
1 ]=> (f f)

;The object 2 is not applicable.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify a procedure to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.
|#