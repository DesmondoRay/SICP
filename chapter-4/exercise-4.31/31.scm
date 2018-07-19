;;; exercise 4.31

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")

;; 判断形参列表是否没有需要添加delay或memo属性的
(define (no-lazy-memo? parameters)
  (null? (filter (lambda (x)
                   (and (list? x)
                        (or (eq? 'lazy (cadr x))
                            (eq? 'lazy-memo (cadr x)))))
                 parameters)))
#|
;; test: no-lazy-memo?
(define p1 '(a (b lazy) c (d lazy-memo)))
(define p2 '(a b c d))
(load "../common/print.scm")
(print
 (no-lazy-memo? p1)
 (no-lazy-memo? p2)
output:
#f
#t
|#

;; 将带有lazy和lazy-memo声明的形参转换为普通的不带声明的形参
(define (to-normal-parameters parameters)
  (map (lambda (x)
         (if (list? x)
             (car x)
             x))
       parameters))
#| 
;; test: to-normal-parameters
(define p1 '(a (b lazy) c (d lazy-memo)))
(display (to-normal-parameters p1))
output: (a b c d)
|#

;; 将一个实参添加memo属性
(define (memo-it arg env)
  (list 'memo arg env))

;; 判断是否带有memo属性
(define (memo? obj)
  (tagged-list? obj 'memo))

;; 将指定的部分实参添加delay或memo属性
(define (delayed-specific-args arguments parameters env)
  (map (lambda (arg par)
         (if (not (list? par))
             arg
             (if (eq? 'lazy (cadr par))
                 (delay-it arg env)
                 (memo-it arg env))))
       arguments parameters))
#| test: delayed-specific-args
(define p1 '(a (b lazy) c (d lazy-memo)))
(define arg '(1 2 3 4))
(display (delayed-specific-args arg p1 'env))
output: (1 (thunk 2 env) 3 (memo 4 env))
|#

;; 修改forct-it以匹配现在的新语法形式
(define (force-it obj)
  (cond ((memo? obj)
         (let ((result (actual-value (thunk-exp obj)
                                     (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj) (thunk-value obj))
        ((thunk? obj)
         (actual-value (thunk-exp obj)
                       (thunk-env obj)))
        (else obj)))
         
;; 修改apply-in-4以匹配现在的新语法形式
(define (apply-in-4 procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (let ((parameters (procedure-parameters procedure)))
           (if (no-lazy-memo? parameters) 
               (eval-sequence               ; 没有lazy和memo的情况
                (procedure-body procedure)
                (extend-environment
                 parameters
                 (list-of-arg-values arguments env)
                 (procedure-environment procedure)))
               (eval-sequence                ; 有lazy和memo的情况
                (procedure-body procedure)
                (extend-environment
                 (to-normal-parameters parameters)  ;转换为不带声明的形参
                 ; 将指定的部分实参添加delay或memo属性
                 (delayed-specific-args arguments parameters env)
                 (procedure-environment procedure))))))
        (else (error "Unknown procedure type: APPLY"
                     procedure))))
