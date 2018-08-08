;;; exercise 5.38 b)

(load "../common/code/ch5-compiler.scm")
(load "../exercise-5.38/38-a.scm")

;; 新增
(define (open-coded? exp) (memq (operator exp) '(= + - *)))

;; 修改
(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((open-coded? exp) (compile-open-code exp target linkage)) ; 新增
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;; 可将compile=，compile+，compile+，compile+整合为一个过程
#|
(define (compile-open-code exp target linkage) 
  (let ((proc (car exp)) 
        (args (spread-arguments (operands exp)))) 
   (end-with-linkage linkage 
    (append-instruction-sequences 
         (car args) 
         (preserving '(arg1) (cadr args) 
          (make-instruction-sequence '(arg1 arg2) (list target) 
           `((assign ,target (op ,proc) (reg arg1) (reg arg2)))))))))
|#

;; 按照书上练习题所述，为基本过程各写一个代码生成器
;; 新增
(define (compile-open-code exp target linkage)
  (let ((proc (operator exp)))
    ((cond ((eq? proc '=) compile=)
           ((eq? proc '+) compile+) 
           ((eq? proc '-) compile-)
           (else compile*))
     exp target linkage)))

(define (compile= exp target linkage)
  (let ((args
         (spread-arguments (operands exp))))
    (end-with-linkage linkage
     (append-instruction-sequences (car args)
      (preserving '(arg1) (cadr args)
       (make-instruction-sequence 
        '(arg1 arg2) (list target)
        `((assign ,target (op =) (reg arg1) (reg arg2)))))))))

(define (compile+ exp target linkage)
  (let ((args
         (spread-arguments (operands exp))))
    (end-with-linkage linkage
     (append-instruction-sequences (car args)
      (preserving '(arg1) (cadr args)
       (make-instruction-sequence 
        '(arg1 arg2) (list target)
        `((assign ,target (op +) (reg arg1) (reg arg2)))))))))

(define (compile- exp target linkage)
  (let ((args
         (spread-arguments (operands exp))))
    (end-with-linkage linkage
     (append-instruction-sequences (car args)
      (preserving '(arg1) (cadr args)
       (make-instruction-sequence 
        '(arg1 arg2) (list target)
        `((assign ,target (op -) (reg arg1) (reg arg2)))))))))

(define (compile* exp target linkage)
  (let ((args
         (spread-arguments (operands exp))))
    (end-with-linkage linkage
     (append-instruction-sequences (car args)
      (preserving '(arg1) (cadr args)
       (make-instruction-sequence 
        '(arg1 arg2) (list target)
        `((assign ,target (op *) (reg arg1) (reg arg2)))))))))
