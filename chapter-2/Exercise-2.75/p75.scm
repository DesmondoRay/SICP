(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) x)
          ((eq? op 'angle) y)
          ((eq? op 'real-part)
           (* x (cos y)))
          ((eq? op 'imag-part)
           (* x (sin y)))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

#| test:
1 ]=> ((make-from-mag-ang 1 3) 'magnitude)

;Value: 1

1 ]=> ((make-from-mag-ang 1 3) 'angle)

;Value: 3

1 ]=> ((make-from-mag-ang 1 3) 'real-part)

;Value: -.9899924966004454

1 ]=> ((make-from-mag-ang 1 3) 'imag-part)

;Value: .1411200080598672

1 ]=> ((make-from-mag-ang 1 3) 'error)

;Unknown op -- MAKE-FROM-REAL-IMAG error
|#