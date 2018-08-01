;;; exercise 5.9

(load "../common/5.2.1-the-machine-model.scm")

(define (make-operation-exp exp machine labels operations)
  (let ((op (lookup-prim (operation-exp-op exp)
                         operations))
        (aprocs
         (map (lambda (e)
                (if (label-exp? e)
                    (error 
                     "operations can't be used on label -- MAKE-OPERATION-EXP"
                     e)
                    (make-primitive-exp e machine labels)))
              (operation-exp-operands exp))))
    (lambda ()
      (apply op (map (lambda (p) (p)) aprocs)))))


;; test
(define exercise-9-machine
  (make-machine
   '(a)
   (list (list 'list list))
   '(start
     (goto (label here))
     here
     (assign a (op list) (label here) (const 4))
     (goto (label there))
     there)))

;; output:
;operations can't be used on label -- MAKE-OPERATION-EXP (label here)