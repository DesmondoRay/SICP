;;; exercise 5.30 a)

(load "../common/code/load-eceval.scm")
;; 修改lookup-variable-value和set-variable-value!过程
(load "30-support.scm")
;; 修改eceval的ev-variable和ev-assignment，在eceval-operations添加(list 'eq? eq?)
(load "30-eceval.scm")

;; test
(define the-global-environment (setup-environment))
(start eceval)

#| output: 
;;; EC-Eval input:
(+ a 3)
unbound-variable-type-error

;;; EC-Eval input:
(set! b 4)
unbound-variable-type-error
|#