;;; exercise 5.12

(load "../common/5.2.1-the-machine-model.scm")

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (instructions '()) ; 新增
        (goto-register '()) ; 新增
        (save-restore-register '()) ; 新增
        (assign-register-sources '())) ; 新增
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))))
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
               (execute)))))
      ;; 新增
      (define (save-instruction inst)
        (let ((inst-list (assoc (car inst) instructions)))
          (if inst-list
              (if (not (member inst inst-list)) ; 排除重复
                  (set-cdr! inst-list (append (cdr inst-list) (list inst))))
              (set! instructions (cons (list (car inst) inst)
                                       instructions)))))
      ;; 新增
      (define (save-goto-register inst)
        (let* ((dest (goto-dest inst))
               (reg-name (register-exp-reg dest)))
          (if (and (register-exp? dest)
                   (not (memq reg-name goto-register)))  ; 排除重复
                  (set! goto-register (append goto-register
                                              (list reg-name))))))
      ;; 新增
      (define (save-save-restore-register inst)
        (if (not (memq (cadr inst) save-restore-register))  ; 排除重复
            (set! save-restore-register (append save-restore-register
                                                (list (cadr inst))))))
      ;; 新增
      (define (save-assign-register-sources inst)
        (let ((reg-name (assign-reg-name inst))
              (value-exp (assign-value-exp inst)))
          (let ((sources-list (assoc reg-name assign-register-sources)))
            (if sources-list
                (if (not (member value-exp sources-list)) ; 排除重复
                    (set-cdr! sources-list (append (cdr sources-list)
                                                   (list value-exp))))
                (set! assign-register-sources (cons (list reg-name value-exp)
                                                    assign-register-sources))))))
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
              ((eq? message 'instructions) instructions) ; 新增
              ((eq? message 'goto-register) goto-register) ; 新增
              ((eq? message 'save-restore-register) ; 新增
               save-restore-register)
              ((eq? message 'assign-register-sources) ; 新增
               assign-register-sources)
              ((eq? message 'save-instruction) ; 新增
               save-instruction)
              ((eq? message 'save-goto-register) ; 新增
               save-goto-register)
              ((eq? message 'save-save-restore-register) ; 新增
               save-save-restore-register)
              ((eq? message 'save-assign-register-sources) ; 新增
               save-assign-register-sources)
              (else (error "Unknown request: MACHINE"
                           message))))
      dispatch)))

(define (make-execution-procedure
         inst labels machine pc flag stack ops)
  ((machine 'save-instruction) inst) ; 新增
  (cond ((eq? (car inst) 'assign)
         ((machine 'save-assign-register-sources) inst) ; 新增
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         ((machine 'save-goto-register) inst) ; 新增
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         ((machine 'save-save-restore-register) inst) ; 新增
         (make-save inst machine stack pc))
        ((eq? (car inst) 'restore)
         ((machine 'save-save-restore-register) inst) ; 新增
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else
         (error "Unknown instruction type: ASSEMBLE"
                inst))))

(define fib-machine
  (make-machine
   '(continue n val)
   (list (list '< <) (list '- -) (list '+ +))
   '(controller
     (assign continue (label fib-done))
     fib-loop
     (test (op <) (reg n) (const 2))
     (branch (label immediate-answer))
     (save continue)
     (assign continue (label afterfib-n-1))
     (goto (label fib-loop)) 
     afterfib-n-1
     (save n)
     (assign n (op -) (reg n) (const 1))
     (restore n)
     (restore continue)
     (assign n (op -) (reg n) (const 2))
     (save continue)
     (assign continue (label afterfib-n-2))
     (save val)
     (goto (label fib-loop))
     (restore val)
     afterfib-n-2
     (assign n (reg val))
     (restore continue)
     (assign val (op +) (reg val) (reg n))
     (goto (reg continue))
     immediate-answer
     (assign val (reg n))
     (goto (reg continue))
     fib-done)))

#| test:
1 ]=> (fib-machine 'instructions)

;Value 13: 
((restore (restore n) 
          (restore continue) 
          (restore val)) 
 (goto (goto (label fib-loop)) 
       (goto (reg continue))) 
 (save (save continue) 
       (save n) 
       (save val)) 
 (branch (branch (label immediate-answer))) 
 (test (test (op <) (reg n) (const 2))) 
 (assign (assign continue (label fib-done)) 
         (assign continue (label afterfib-n-1)) 
         (assign n (op -) (reg n) (const 1)) 
         (assign n (op -) (reg n) (const 2)) 
         (assign continue (label afterfib-n-2)) 
         (assign n (reg val)) 
         (assign val (op +) (reg val) (reg n)) 
         (assign val (reg n))))

1 ]=> (fib-machine 'goto-register)

;Value 14: (continue)

1 ]=> (fib-machine 'save-restore-register)

;Value 15: (continue n val)

1 ]=> (fib-machine 'assign-register-sources)

;Value 16: 
 ((val ((op +) (reg val) (reg n)) 
       ((reg n))) 
  (n ((op -) (reg n) (const 1)) 
     ((op -) (reg n) (const 2)) 
     ((reg val))) 
  (continue ((label fib-done)) 
            ((label afterfib-n-1)) 
            ((label afterfib-n-2))))
|#