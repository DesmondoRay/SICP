(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base s) (cadr s))

(define (exponent s) (caddr s))

(define (make-exponentiation e1 e2)
  (cond ((=number? e2 0) 1)
		((=number? e2 1) e1)
		((and (number? e1) (number? e2)) (exp e1 e2))
		(else (list '** e1 e2))))