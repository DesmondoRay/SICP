(define (equal? a b)
  (cond ((not (pair? a))
		 (eq? a b))
	  	((not (eq? (car a) (car b)))
		 false)
		(else (equal? (cdr a) (cdr b)))))

(equal? '(this is a list ) '(this is a list))
(equal? '(this (is a) list ) '(this is a list))