(load "../common/2-3-2-deriv.scm")

(define (augend s)
  (let ((aug (cddr s)))
    (if (null? (cdr aug))
        (car aug)
        (append (list '+) aug))))

(define (multiplicand p)
  (let ((mul (cddr p)))
    (if (null? (cdr mul))
        (car mul)
        (append (list '*) mul))))

#|
1 ]=> (deriv '(* x y (+ x 3)) 'x)

;Value 13: (+ (* x y) (* y (+ x 3)))
|#