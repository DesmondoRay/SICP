;;; Streams as Lazy Lists
;;; page 284, 4.2.3

;; 在指定环境内添加惰性list到相关定义
(define (define-lazy-list-in-env env)
  (eval-in-4 '(define (cons x y) (lambda (m) (m x y))) env)
  (eval-in-4 '(define (car z) (z (lambda (p q) p))) env)
  (eval-in-4 '(define (cdr z) (z (lambda (p q) q))) env)
  (eval-in-4 
   '(define (list-ref items n)
      (if (= n 0)
          (car items)
          (list-ref (cdr items) (- n 1)))) 
   env)
  (eval-in-4 
   '(define (list-ref items n)
      (if (= n 0)
          (car items)
          (list-ref (cdr items) (- n 1)))) 
   env)
  (eval-in-4 
   '(define (map proc items)
      (if (null? items)
          '()
          (cons (proc (car items)) (map proc (cdr items))))) 
   env)
  (eval-in-4 
   '(define (scale-list items factor)
      (map (lambda (x) (* x factor)) items))
   env)
  (eval-in-4 
   '(define (add-lists list1 list2)
      (cond ((null? list1) list2)
            ((null? list2) list1)
            (else (cons (+ (car list1) (car list2))
                        (add-lists (cdr list1) (cdr list2))))))
   env)
  (eval-in-4 '(define ones (cons 1 ones)) env)
  (eval-in-4 '(define integers (cons 1 (add-lists ones integers))) env))

