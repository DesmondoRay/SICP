;;; print all results

(define (print . args)
  (cond ((null? args)
		 (newline)
		 (display "Print done!"))
		(else (newline)
			  (display (car args))
			  (apply print (cdr args)))))