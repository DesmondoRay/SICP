;;; exercise 5.22

(load "../common/5.2.1-the-machine-model.scm")

(define append-machine
  (make-machine
   '(x y result temp continue)
   (list (list 'null? null?) (list 'car car) 
         (list 'cdr cdr) (list 'cons cons))
   '(controller
     (assign result (reg y))
     (assign continue (label append-done))
     
     test-loop
     (test (op null?) (reg x))
     (branch (label null-x))
     (assign temp (op car) (reg x))
     (save temp)
     (save continue)
     (assign continue (label null-x))
     (assign x (op cdr) (reg x))
     (goto (label test-loop))
     
     null-x
     (restore continue)
     (restore temp)
     (assign result (op cons) (reg temp) (reg result))
     (goto (reg continue))
     
     append-done)))

#| test
1 ]=> (set-register-contents! append-machine 'x '(1 2 3))

;Value: done

1 ]=> (set-register-contents! append-machine 'y '(4 5 6))

;Value: done

1 ]=> (start append-machine)

;Value: done

1 ]=> (get-register-contents append-machine 'result)

;Value 13: (1 2 3 4 5 6)
|#