;;; exercise 5.10

(load "../common/5.2.1-the-machine-model.scm")

;; 添加(exit)指令，遇到该指令时，直接退出当前程序
(define (make-execution-procedure
         inst labels machine pc flag stack ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine stack pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        ((eq? (car inst) 'exit) ; new
         (make-exit pc))
        (else
         (error "Unknown instruction type: ASSEMBLE"
                inst))))

(define (make-exit pc)
  (lambda () (set-contents! pc '())))


;; test
(define exercise-10-machine
  (make-machine
   '(a)
   (list '())
   '(start
     (assign a (const 1))
     (exit)
     (assign a (const 2))
     done)))

#| output: 
1 ]=> (start exercise-10-machine)

;Value: done

1 ]=> (get-register-contents exercise-10-machine 'a)

;Value: 1
|#