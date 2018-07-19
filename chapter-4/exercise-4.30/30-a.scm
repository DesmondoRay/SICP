;;; exercise-4.30 a)

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")


#|
;; test:
(driver-loop)

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