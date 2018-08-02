;;; exercise 5.22

(load "../common/5.2.1-the-machine-model.scm")

(define append!-machine
  (make-machine
   '(x y cdr-x last)
   (list (list 'null? null?) (list 'car car) 
         (list 'cdr cdr) (list 'set-cdr! set-cdr!))
   '(controller
     (assign cdr-x (op cdr) (reg x))
     (assign last (reg x)) ; 若是不加这个步骤，当x为只有单个元素时，会出错
     
     last-pair-loop
     (test (op null?) (reg cdr-x))
     (branch (label null-cdr-x))
     (assign last (reg cdr-x))
     (assign cdr-x (op cdr) (reg cdr-x))
     (goto (label last-pair-loop))
     
     null-cdr-x
     (perform (op set-cdr!) (reg last) (reg y))
     
     append!-done)))

#| test: 
1 ]=> (set-register-contents! append!-machine 'x '(1 2 3))

;Value: done

1 ]=> (set-register-contents! append!-machine 'y '(4 5 6))

;Value: done

1 ]=> (start append!-machine)

;Value: done

1 ]=> (get-register-contents append!-machine 'x)

;Value 13: (1 2 3 4 5 6)
|#


#| 测试x为单个元素的情况
1 ]=> (set-register-contents! append!-machine 'x '(1))    

;Value: done

1 ]=> (set-register-contents! append!-machine 'y '(4 5 6))

;Value: done

1 ]=> (start append!-machine)

;Value: done

1 ]=> (get-register-contents append!-machine 'x)

;Value 13: (1 4 5 6)
|#