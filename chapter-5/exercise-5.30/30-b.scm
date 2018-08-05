;;; exercise 5.30 b)

(load "../common/code/load-eceval.scm")
;; 修改apply-primitive-procedure
(load "30-apply-primitive-procedure.scm")
;; 修改eceval的primitive-apply
(load "30-eceval.scm")

;; test
(define the-global-environment (setup-environment))
(start eceval)

#| output: 
;;; EC-Eval input:
(car 1)
error-argument-to-car-or-cdr

;;; EC-Eval input:
(cdr 1)
error-argument-to-car-or-cdr

;;; EC-Eval input:
(/ 1 0)
division-by-zero-error
|#
