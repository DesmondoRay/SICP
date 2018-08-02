;;; exercise 5.15

(load "../common/5.2.1-the-machine-model.scm")
(load "../common/5.2.4-monitoring-machine-performance.scm")

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (instruction-count 0)) ; 指令计数
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics  ; 5.2.4节新增
                       (lambda () (stack 'print-statistics)))
                 (list 'print-instruction-count  ; 打印指令计数
                       (lambda () (newline)
                         (display (list 'instruction-count '= 
                                        instruction-count))
                         (set! instruction-count 0)
                         (newline)
                         (newline)))))
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
               ((instruction-execution-proc (car insts)))
               (set! instruction-count ; 更新指令计数
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


;; test
(define fact-machine
  (make-machine
   '(continue n val)
   (list (list '= =) (list '- -) (list '* *) (list 'newline newline)
         (list 'read read) (list 'display display))
   '(controller
     loop
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
     (perform (op print-instruction-count)) ; 打印检测结果
     (goto (label loop)))))

(start fact-machine)

;; 注：在计数时，会将(perform (op print-instruction-count))等执行监测机器的操作
; 也算作执行的指令，从而导致计数会比不监测机器情况下的要多，后面的习题也有同样的问题。
; 解决办法是将print-instruction-count过程定义于make-new-machine过程内，
; 调用(fact-machine 'print-instruction-count)打印计数结果，而不是在模型内添加相关操作。

#| output:
input n: 1
(fact n) = 1
(instruction-count = 9)

input n: 2
(fact n) = 2
(instruction-count = 22)

input n: 3
(fact n) = 6
(instruction-count = 33)

input n: 4
(fact n) = 24
(instruction-count = 44)

input n: 5
(fact n) = 120
(instruction-count = 55)

input n: 6
(fact n) = 720
(instruction-count = 66)

input n: 7
(fact n) = 5040
(instruction-count = 77)

input n: 8
(fact n) = 40320
(instruction-count = 88)

input n: 9
(fact n) = 362880
(instruction-count = 99)

input n: 10
(fact n) = 3628800
(instruction-count = 110)
|#