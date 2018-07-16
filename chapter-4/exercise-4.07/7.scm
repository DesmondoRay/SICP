;;; exercise 4.7
;; let*语句的样式(list 'let* ((<var><exp>)..) <body>)

(load "../exercise-4.06/6.scm")

(define (let*? exp) (tagged-list? exp 'let*))

(define (let*-code exp) (cdr exp))

(define (let*-first-var-exp code) (caar code)) ;; 第一个(<var><exp>)

(define (let*-rest-vars-exps code) (cdar code)) ;; 剩余的(<var><exp>)

(define (let*-body code) (cadr code)) 

(define (let*-rest code)	; 剩余的(<var><exp>) 和 <body>
  (list (let*-rest-vars-exps code) 
		(let*-body code)))

; 判断是否为最后一个(<var><exp>)
(define (last-var-exp? code) (null? (cdar code))) 


(define (eval-let* exp env)
  (eval-in-4 (let*->nested-lets (let*-code exp)) env))

(define (make-let vars-exps body)
  (list 'let (list vars-exps) body))

(define (let*->nested-lets exp)
  (if (last-var-exp? exp)
	  (make-let (let*-first-var-exp exp)
				(let*-body exp))
	  (make-let (let*-first-var-exp exp)
				(let*->nested-lets (let*-rest exp)))))

;; 将eval-let加入table
(put 'op 'let* eval-let*)


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(let* ((x 3) 
	   (y (+ x 2)) 
	   (z (+ x y 5))) 
  (* x z))

;;; M-Eval value: 
39
|#