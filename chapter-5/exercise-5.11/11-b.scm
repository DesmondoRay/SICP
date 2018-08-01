;;; exercise 5.11 b)

(load "../common/5.2.1-the-machine-model.scm")

(define (make-save inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name)))
      (lambda ()
        (push stack (cons reg-name ; changed
                          (get-contents reg)))
        (advance-pc pc)))))

(define (make-restore inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name)))
      (lambda ()
        (let ((contents (pop stack)))
          (if (eq? reg-name (car contents))
              (set-contents! reg (cdr contents))
              (error "not the same register -- MAKE-RESTORE"
                     reg-name)))
        (advance-pc pc)))))


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
     done)))

#| output: 
1 ]=> (start exercise-11-machine)

;not the same register -- MAKE-RESTORE a
|#