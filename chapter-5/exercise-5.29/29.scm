;;; exercise 5.29

;; a) maximum depth: 5n + 3

;; b) S(n) = S(n-1) + S(n-2) + 40; S(n) = 56Fib(n+1) - 40;

;; test
(load "../common/code/load-eceval.scm")

(define the-global-environment (setup-environment))

(start eceval)

#| output: 
;;; EC-Eval input:
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(total-pushes = 3 maximum-depth = 3)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(fib 1)

(total-pushes = 16 maximum-depth = 8)
;;; EC-Eval value:
1

;;; EC-Eval input:
(fib 2)

(total-pushes = 72 maximum-depth = 13)
;;; EC-Eval value:
1

;;; EC-Eval input:
(fib 3)

(total-pushes = 128 maximum-depth = 18)
;;; EC-Eval value:
2

;;; EC-Eval input:
(fib 4)

(total-pushes = 240 maximum-depth = 23)
;;; EC-Eval value:
3

;;; EC-Eval input:
(fib 5)

(total-pushes = 408 maximum-depth = 28)
;;; EC-Eval value:
5
|#