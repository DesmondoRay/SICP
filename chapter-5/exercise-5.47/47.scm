;;; exercise 5.47

;; 在解释器内定义过程，会调用make-procedure-->(list 'procedure parameters body env);
;; 在编译过程时，会调用make-compiled-procedure-->(list 'compiled-procedure entry env);
;; 所以可以根据过程类型判断出过程的类型，从而在compile-procedure-call过程内进行处理。

(load "../common/code/ch5-compiler.scm")
(load "../common/code/load-eceval-compiler.scm")

(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive-branch))
        (compiled-branch (make-label 'compiled-branch))               
        (compound-branch (make-label 'compound-branch))                 ; ***
        (after-call (make-label 'after-call)))
    (let ((compiled-or-compound-linkage
           (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
       (make-instruction-sequence '(proc) '()
        `((test (op primitive-procedure?) (reg proc))
          (branch (label ,primitive-branch))))
       (parallel-instruction-sequences
        (append-instruction-sequences                                   ; ***
         (make-instruction-sequence '(proc) '()                         ; ***
          `((test (op compound-procedure?) (reg proc))                  ; ***
            (branch (label ,compound-branch))))                         ; ***
         (parallel-instruction-sequences                                ; ***
          (append-instruction-sequences                                 ; ***
           compiled-branch                                              ; ***
           (compile-proc-appl target compiled-or-compound-linkage))     ; ***
          (append-instruction-sequences                                 ; ***
           compound-branch                                              ; ***
           (compound-proc-appl target compiled-or-compound-linkage))))  ; ***
        (append-instruction-sequences
         primitive-branch
         (end-with-linkage linkage
          (make-instruction-sequence '(proc argl)
                                     (list target)
           `((assign ,target
                     (op apply-primitive-procedure)
                     (reg proc)
                     (reg argl)))))))
       after-call))))

;; 新增compound-proc-appl过程，用于调用复合(解释)过程;
;; 与compile-proc-appl不同点用***标出
(define (compound-proc-appl target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
         (make-instruction-sequence '(proc) all-regs
            `((assign continue (label ,linkage))
              (save continue)                                           ; ***
             (goto (reg compapp)))))                                    ; ***
        ((and (not (eq? target 'val))
              (not (eq? linkage 'return)))
         (let ((proc-return (make-label 'proc-return)))
           (make-instruction-sequence '(proc) all-regs
            `((assign continue (label ,proc-return))
              (save continue)                                           ; ***
              (goto (reg compapp))                                      ; ***
              ,proc-return
              (assign ,target (reg val))
              (goto (label ,linkage))))))
        ((and (eq? target 'val) (eq? linkage 'return))
         (make-instruction-sequence '(proc continue) all-regs
          '((save continue)                                             ; ***
            (goto (reg compapp)))))                                     ; ***
        ((and (not (eq? target 'val)) (eq? linkage 'return))
         (error "return linkage, target not val -- COMPILE"
                target))))

;; test

(compile-and-go
 '(define (f n)
    (g n)))

#| output: 
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(define (g n)
  (if (= n 1)
      1 
      (* (g (- n 1)) n)))

(total-pushes = 3 maximum-depth = 3)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(f 5)

(total-pushes = 145 maximum-depth = 28)
;;; EC-Eval value:
120
|#