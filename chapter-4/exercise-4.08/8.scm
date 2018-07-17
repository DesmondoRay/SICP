;;; exercise 4.8
;; “命名let”: (list 'let <var> <bindings> <body>)

(load "../exercise-4.03/3.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let-name exp) (cadr exp)) ; var用于判断let是否为“命名let”

(define (eval-let exp env)
  (eval-in-4 (let->combination exp) env))

(define (let->combination exp)
  (if (not (list? (let-name exp)))
      (let->combination-named exp)  ; “命名let”
      (let->combination-normal exp))) ; “普通let”

(define (make-application operator operands)
  (cons operator operands))

(define (make-definition func body)
  (list 'define func body))

; “普通let”
(define (let->combination-normal exp)
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  (define (let-body exp) (cddr exp))
  (make-application (make-lambda (let-vars exp) (let-body exp))
                    (let-exps exp)))

; “命名let”
(define (let->combination-named exp)
  (define (let-vars exp) (map car (caddr exp)))
  (define (let-vals exp) (map cadr (caddr exp)))
  (define (let-body exp) (cadddr exp))
  #|
  (display (let-name exp))
  (newline)
  (display (let-vars exp))
  (newline)
  (display (let-vals exp))
  (newline)
  (display (let-body exp))
  (newline)
  |#
  (sequence->exp
   (list (make-definition (cons (let-name exp) (let-vars exp))
                          (let-body exp))
         (make-application (let-name exp) (let-vals exp)))))

;; 将eval-let加入元循环求值器
(put 'op 'let eval-let)


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define (fib n)
  (let fib-iter ((a 1) (b 0) (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(fib 4)

;;; M-Eval value: 
3

;;; M-Eval input: 
(fib 6)

;;; M-Eval value: 
8
|#