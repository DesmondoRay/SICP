;;; exercise 5.11 c)

(load "../common/5.2.1-the-machine-model.scm")

(define (make-stack)
  (let ((stacks '()))
    ; 当需要push一个寄存器的值时，判断是否有与该寄存器关联的stack
    (define (push reg-name val)
      (let ((reg-stack (assoc reg-name stacks)))
        (if reg-stack
            (set-cdr! reg-stack (cons val (cdr reg-stack)))
            (begin ; 若是没有，则添加一个stack，与该寄存器关联
             (add-reg-stack reg-name)
             (push reg-name val)))))
    (define (add-reg-stack reg-name) ; 添加一个stack，与寄存器关联
      (set! stacks (cons (cons reg-name '())
                         stacks)))
    (define (pop reg-name)
      (let ((reg-stack (assoc reg-name stacks)))
        (if reg-stack
            (if (null? reg-stack)
                (error "Empty stack -- POP")
                (let ((top (cadr reg-stack)))
                  (set-cdr! reg-stack (cddr reg-stack))
                  top))
            ; 没有找到与之关联的stack
            (error "the register is not associated with any stack -- POP"
                   reg-name))))
    (define (initialize)
      (for-each (lambda (stack)
                  (set-cdr! stack '()))
                stacks))
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) pop)
            ((eq? message 'initialize) (initialize))
            (else (error "Unknown request: STACK" message))))
    dispatch))

(define (pop stack reg-name)
  ((stack 'pop) reg-name))

(define (push stack reg-name val)
  ((stack 'push) reg-name val))

(define (make-save inst machine stack pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (stack-inst-reg-name inst) (get-contents reg)) ; changed
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst))))
    (lambda ()
      (set-contents! reg (pop stack (stack-inst-reg-name inst))) ; changed
      (advance-pc pc))))


;; test
(define exercise-11-machine
  (make-machine
   '(a b)
   (list '())
   '(start
     (assign a (const 1))
     (save a)
     (assign b (const 2))
     (save b)
     (restore a)
     (restore b)
     done)))

#| output: 
1 ]=> (start exercise-11-machine)

;Value: done

1 ]=> (get-register-contents exercise-11-machine 'a)

;Value: 1

1 ]=> (get-register-contents exercise-11-machine 'b)

;Value: 2
|#