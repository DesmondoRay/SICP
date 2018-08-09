;;; exercise 5.49

(load "../common/code/ch5-compiler.scm")
(load "../common/code/load-eceval-compiler.scm")

(define the-global-environment (setup-environment))

(define (compile-and-assemble exp)
  (assemble (statements
             (compile exp 'val 'return))
            compile-eval-machine))

(set! eceval-operations
      (append eceval-operations
              (list 
               (list 'compile-and-assemble compile-and-assemble))))

(define compile-eval-machine
  (make-machine
   '(exp env val proc argl continue unev)
   eceval-operations
   '(
    read-compile-eval-print-loop
     (perform (op initialize-stack))
     (perform 
      (op prompt-for-input) (const ";;; EC-Eval input:"))
     (assign exp (op read))
     (assign env (op get-global-environment))
     (assign continue (label print-result))
     (assign val (op compile-and-assemble) (reg exp))
     (goto (reg val))
     print-result
     (perform (op print-stack-statistics))
     (perform
      (op announce-output) (const ";;; EC-Eval value:"))
     (perform (op user-print) (reg val))
     (goto (label read-compile-eval-print-loop)))))

(start compile-eval-machine)
#|
;;; EC-Eval input:
(define (fact n)
  (if (= n 1)
      1
      (* (fact (- n 1)) n)))

(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(fact 5)

(total-pushes = 26 maximum-depth = 14)
;;; EC-Eval value:
120
|#
