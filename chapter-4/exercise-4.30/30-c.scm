;;; exercise-4.30 c)

(load "30-b.scm")

#|
;; test

;;; L-Eval input:
(define (for-each proc items)
  (if (null? items)
	  'done
	  (begin (proc (car items))
			 (for-each proc (cdr items)))))

;;; L-Eval value:
ok

;;; L-Eval input:
(for-each (lambda (x) (newline) (display x))
		  (list 57 321 88))

57
321
88
;;; L-Eval value:
done
|#