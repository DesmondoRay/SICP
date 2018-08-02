;;; exercise 5.18

(load "../exercise-5.17/17.scm")

(define (make-register name)
  (let ((contents '*unassigned*)
        (trace-on false)) ; 新增
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'set)
             (lambda (value) 
               (if trace-on  ; 新增
                   (begin
                    (display (list 'name: name "," 
                                   'old-value: contents "," 
                                   'new-value: value))
                    (newline)))
               (set! contents value)))
            ((eq? message 'trace-on) (set! trace-on true)) ; 新增
            ((eq? message 'trace-off) (set! trace-on false)) ; 新增
            (else
             (error "Unknown request: REGISTER" message))))
    dispatch))

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
      ;; 练习5.18
      (define (trace-on-register name)
        (let ((reg (assoc name register-table)))
          (if reg
              ((cadr reg) 'trace-on)
              (error "Unknown register:" name))))
      ;; 练习5.18
      (define (trace-off-register name)
        (let ((reg (assoc name register-table)))
          (if reg
              ((cadr reg) 'trace-off)
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
              ((eq? message 'trace-on-register) trace-on-register) ; 练习5.18
              ((eq? message 'trace-off-register) trace-off-register) ; 练习5.18
              (else (error "Unknown request: MACHINE"
                           message))))
      dispatch)))


;; test
(define fact-machine
  (make-machine
   '(continue n val)
   (list (list '= =) (list '- -) (list '* *) (list 'newline newline)
         (list 'read read) (list 'display display))
   '(loop
     (perform (op display) (const "input n: "))
     (assign n (op read)) ; 读取输入
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
     fact-done
     (perform (op display) (const "(fact n) = ")) ; 打印计算结果
     (perform (op display) (reg val))
     (perform (op newline))
     (perform (op newline))
     (goto (label loop)))))


((fact-machine 'trace-on-register) 'n)  ; 跟踪寄存器 n
((fact-machine 'trace-on-register) 'val) ; 跟踪寄存器 val
(start fact-machine)

#|  output: 
input n: 1
(name: n , old-value: *unassigned* , new-value: 1)
(name: val , old-value: *unassigned* , new-value: 1)
(fact n) = 1

input n: 2
(name: n , old-value: 1 , new-value: 2)
(name: n , old-value: 2 , new-value: 1)
(name: val , old-value: 1 , new-value: 1)
(name: n , old-value: 1 , new-value: 2)
(name: val , old-value: 1 , new-value: 2)
(fact n) = 2

input n: 3
(name: n , old-value: 2 , new-value: 3)
(name: n , old-value: 3 , new-value: 2)
(name: n , old-value: 2 , new-value: 1)
(name: val , old-value: 2 , new-value: 1)
(name: n , old-value: 1 , new-value: 2)
(name: val , old-value: 1 , new-value: 2)
(name: n , old-value: 2 , new-value: 3)
(name: val , old-value: 2 , new-value: 6)
(fact n) = 6
|#