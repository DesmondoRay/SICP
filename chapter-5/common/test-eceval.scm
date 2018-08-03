;;; 5.4 test eceval

(load "code/load-eceval.scm")

(define the-global-environment (setup-environment))

(start eceval)

#| output: 
;;; EC-Eval input:
(define (factorial n)
  (if (= n 1) 1 (* (factorial (- n 1)) n)))

(total-pushes = 3 maximum-depth = 3)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 5)

(total-pushes = 144 maximum-depth = 28)
;;; EC-Eval value:
120
|#