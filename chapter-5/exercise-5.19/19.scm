;;; exercise 5.19

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
                       (lambda () (stack 'print-statistics)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag)))
          (breakpoints '()) ; 练习5.19
          (break false)) ; 练习5.19
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
        (let ((bp (assoc (+ instruction-count 1) breakpoints)))
          (if (and bp break) ; 练习5.19
              (begin (display (list 'label: (cadr bp) "," 'offset: (car bp)))
                     (newline))
              (begin 
               (set! break true) ; 练习5.19
              (let ((insts (get-contents pc)))
                (if (null? insts)
                    'done
                    (begin
                     ((instruction-execution-proc (car insts)))
                     (set! instruction-count ; 更新指令计数
                           (+ 1 instruction-count))
                     (execute))))))))
      ;; 练习5.19
      (define (set-breakpoint label n)
        (set! breakpoints (cons (list n label) breakpoints))
        (set! break true)
        'set-breakpoint)
      ;; 练习5.19
      (define (proceed-machine)
        (set! break false)
        (execute))
      ;; 练习5.19
      (define (cancel-breakpoint label n)
        (let ((bp (assoc n breakpoints)))
          (if bp
              (begin (set! breakpoints 
                           (filter (lambda (x)
                                     (not (= n (car x))))
                                   breakpoints))
                     'cancel-breakpoint)
              (error "Unknown breakpoint -- CANCEL-BREAKPOINT"
                     label))))
      ;; 练习5.19
      (define (cancel-all-breakpoint)
        (set! breakpoints '())
        'cancel-all-breakpoint)
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (set! instruction-count 0) ; 练习5.19
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
              ((eq? message 'set-breakpoint) set-breakpoint) ; 练习5.19
              ((eq? message 'proceed-machine) proceed-machine) ; 练习5.19
              ((eq? message 'cancel-breakpoint) cancel-breakpoint) ; 练习5.19
              ((eq? message 'cancel-all-breakpoint) ; 练习5.19
               cancel-all-breakpoint)
              (else (error "Unknown request: MACHINE"
                           message))))
      dispatch)))


;; 练习5.19新增
(define (set-breakpoint machine label n)
  ((machine 'set-breakpoint) label n))

(define (proceed-machine machine)
  ((machine 'proceed-machine)))

(define (cancel-breakpoint machine label n)
  ((machine 'cancel-breakpoint) label n))

(define (cancel-all-breakpoint machine)
  ((machine 'cancel-all-breakpoint)))
  

;; test
(define fact-machine
  (make-machine
   '(continue n val)
   (list (list '= =) (list '- -) (list '* *) (list 'newline newline)
         (list 'read read) (list 'display display))
   '(controller
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
     (perform (op display) (reg val)))))


#| <test 1>: set-breakpoint, proceed-machine, cancel-breakpoint
1 ]=> (set-breakpoint fact-machine 'test-19-1 4)

;Value: set-breakpoint

1 ]=> (set-breakpoint fact-machine 'test-19-2 6)

;Value: set-breakpoint

1 ]=> (set-breakpoint fact-machine 'test-19-3 8)

;Value: set-breakpoint

1 ]=> (cancel-breakpoint fact-machine 'test-19-1 4)

;Value: cancel-breakpoint

1 ]=> (start fact-machine)
input n: 5
(label: test-19-2 , offset: 6)
;Unspecified return value

1 ]=> (proceed-machine fact-machine)
(label: test-19-3 , offset: 8)
;Unspecified return value

1 ]=> (proceed-machine fact-machine)
(fact n) = 120
;Value: done
|#


#| <test 2>: cancel-all-breakpoint
1 ]=> (set-breakpoint fact-machine 'test-19-1 4)

;Value: set-breakpoint

1 ]=> (set-breakpoint fact-machine 'test-19-2 8)

;Value: set-breakpoint

1 ]=> (cancel-all-breakpoint fact-machine)

;Value: cancel-all-breakpoint

1 ]=> (start fact-machine)
input n: 5
(fact n) = 120
;Value: done
|#
