;;; exercise 5.17

(load "../common/5.2.1-the-machine-model.scm")
(load "../common/5.2.4-monitoring-machine-performance.scm")

;; 新增
(define (make-instruction-and-label inst label)
  (list inst label '()))

;; 修改
(define (make-instruction text)
  (list text '() '()))

;; 修改
(define (instruction-execution-proc inst)
  (caddr inst)) ;;;;

;; 修改
(define (set-instruction-execution-proc! inst proc)
  (set-car! (cddr inst) proc))

;; 新增
(define (instruction-label inst)
  (cadr inst))

;; 修改，按照365页，脚注289的形式重写extract-labels和assemble
(define (extract-labels text)
  (if (null? text)
      (cons '() '())
      (let ((result (extract-labels (cdr text))))
        (let ((insts (car result)) (labels (cdr result)))
          (let ((next-inst (car text)))
            (if (symbol? next-inst)
                (let ((insts 
                       (if (null? insts)
                           '()
                           (cons (make-instruction-and-label
                                  (instruction-text (car insts))
                                  next-inst)
                                 (cdr insts)))))
                  (cons insts
                        (cons (make-label-entry next-inst insts) labels)))
                (cons (cons (make-instruction next-inst) insts)
                      labels)))))))

(define (assemble controller-text machine)
  (let ((result (extract-labels controller-text)))
    (let ((insts (car result)) (labels (cdr result)))
      (update-insts! insts labels machine)
      insts)))

;; 修改
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (instruction-count 0) ; 练习5.15 指令计数
        (trace-switch 0)) ; 练习5.16 trace开关，0表示关
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics  ; 5.2.4节新增
                       (lambda () (stack 'print-statistics)))
                 (list 'initialize-instruction-count ; 练习5.15 初始化指令计数
                       (lambda () (set! instruction-count 0)))
                 (list 'print-instruction-count  ; 练习5.15 打印指令计数
                       (lambda () (newline)
                         (display (list 'instruction-count '= 
                                        instruction-count))))
                 ; 练习5.16 trace-on 和 trace-off
                 (list 'trace-on (lambda () (set! trace-switch 1)))
                 (list 'trace-off (lambda () (set! trace-switch 0)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
               (if (= trace-switch 1)
                    ; 练习5.17 判断指令的前面是否为label
                   (begin
                    (if (not (null? (instruction-label (car insts))))
                        (begin (display (list 'label ':
                                              (instruction-label (car insts))))
                               (newline)))
                    (begin (display (list 'text ': 
                                          (instruction-text (car insts))))
                           (newline))))
               ((instruction-execution-proc (car insts)))
               (set! instruction-count ; 练习5.15 更新指令计数
                     (+ 1 instruction-count))
               (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq)
                 (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register)
               allocate-register)
              ((eq? message 'get-register)
               lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops)
                 (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request: MACHINE"
                           message))))
      dispatch)))

#|
;; test
(define fact-machine
  (make-machine
   '(continue n val)
   (list (list '= =) (list '- -) (list '* *) (list 'newline newline)
         (list 'read read) (list 'display display))
   '(loop
     (perform (op display) (const "input n: "))
     (assign n (op read)) ; 读取输入
     (perform (op trace-on)) ; trace-on
     (assign continue (label fact-done))
     fact-loop
     (test (op =) (reg n) (const 1))
     (branch (label base-case))
     (save continue)
     (save n)
     (assign n (op -) (reg n) (const 1))
     (assign continue (label after-fact))
     (goto (label fact-loop))
     after-fact
     (restore n)
     (restore continue)
     (assign val (op *) (reg n) (reg val))
     (goto (reg continue))
     base-case
     (assign val (const 1))
     (goto (reg continue))
     (perform (op trace-off)) ; trace-off
     fact-done
     (perform (op display) (const "(fact n) = ")) ; 打印计算结果
     (perform (op display) (reg val))
     (perform (op newline))
     (perform (op newline))
     (goto (label loop)))))

(start fact-machine)

;; output:
input n: 1
(text : (assign continue (label fact-done)))
(label : fact-loop)
(text : (test (op =) (reg n) (const 1)))
(text : (branch (label base-case)))
(label : base-case)
(text : (assign val (const 1)))
(text : (goto (reg continue)))
(label : fact-done)
(text : (perform (op trace-off)))
(fact n) = 1

input n: 2
(text : (assign continue (label fact-done)))
(label : fact-loop)
(text : (test (op =) (reg n) (const 1)))
(text : (branch (label base-case)))
(text : (save continue))
(text : (save n))
(text : (assign n (op -) (reg n) (const 1)))
(text : (assign continue (label after-fact)))
(text : (goto (label fact-loop)))
(label : fact-loop)
(text : (test (op =) (reg n) (const 1)))
(text : (branch (label base-case)))
(label : base-case)
(text : (assign val (const 1)))
(text : (goto (reg continue)))
(label : after-fact)
(text : (restore n))
(text : (restore continue))
(text : (assign val (op *) (reg n) (reg val)))
(text : (goto (reg continue)))
(label : fact-done)
(text : (perform (op trace-off)))
(fact n) = 2
|#