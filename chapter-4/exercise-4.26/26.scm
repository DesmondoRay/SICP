;;; exercise 4.26

(load "../exercise-4.03/3.scm")

(define (unless? exp) (tagged-list? exp 'unless))

(define (unless-condition exp) (cadr exp))

(define (unless-usual exp) (caddr exp))

(define (unless-exceptional exp) (cadddr exp))

(define (eval-unless exp env)
  (eval-in-4 (unless->if exp) env))

(define (unless->if exp)
  (make-if (unless-condition exp)
           (unless-exceptional exp)
           (unless-usual exp)))

(put 'op 'unless eval-unless)


#|
;; test
(driver-loop)

;;; M-Eval input: 
(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(factorial 5)

;;; M-Eval value: 
120
|#