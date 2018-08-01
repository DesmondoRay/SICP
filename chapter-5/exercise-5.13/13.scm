;;; exercise 5.13

(load "../common/5.2.1-the-machine-model.scm")

(define (make-machine #|register-names|# ops controller-text)
  (let ((machine (make-new-machine)))
    #|
    (for-each
     (lambda (register-name)
       ((machine 'allocate-register) register-name))
     register-names)
    |#
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '()))
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
              (begin (allocate-register name) ; changed
                     (lookup-register name)))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
               ((instruction-execution-proc (car insts)))
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
(define expt-machine-iter
  (make-machine
   (list (list '= =) (list '* *) (list '- -))
   '((assign counter (reg n))
     (assign product (const 1))
     test-expt
     (test (op =) (reg counter) (const 0))
     (branch (label expt-done))
     (assign product (op *) (reg b) (reg product))
     (assign counter (op -) (reg counter) (const 1))
     (goto (label test-expt))
     expt-done)))

#| output: 
1 ]=> (set-register-contents! expt-machine-iter 'b 3)

;Value: done

1 ]=> (set-register-contents! expt-machine-iter 'n 3)

;Value: done

1 ]=> (start expt-machine-iter)

;Value: done

1 ]=> (get-register-contents expt-machine-iter 'product)

;Value: 27
|#