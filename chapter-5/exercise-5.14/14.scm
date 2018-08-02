;;; exercise 5.14

;; 修改make-new-machine，添加print-stack-statistics操作
(load "../common/5.2.1-the-machine-model.scm")
(load "../common/5.2.4-monitoring-machine-performance.scm")

(define fact-machine
  (make-machine
   '(continue n val)
   (list (list '= =) (list '- -) (list '* *) (list 'newline newline)
         (list 'read read) (list 'display display))
   '(controller
     loop
     (perform (op display) (const "input n: "))
     (assign n (op read)) ; 读取输入
     (perform (op initialize-stack)) ; 初始化
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
     (perform (op print-stack-statistics)) ; 打印检测结果
     (perform (op newline))
     (perform (op newline))
     (goto (label loop)))))

(start fact-machine)

#| output: 
input n: 1
(fact n) = 1
(total-pushes = 0 maximum-depth = 0)

input n: 2
(fact n) = 2
(total-pushes = 2 maximum-depth = 2)

input n: 3
(fact n) = 6
(total-pushes = 4 maximum-depth = 4)

input n: 4
(fact n) = 24
(total-pushes = 6 maximum-depth = 6)

input n: 5
(fact n) = 120
(total-pushes = 8 maximum-depth = 8)

input n: 7
(fact n) = 5040
(total-pushes = 12 maximum-depth = 12)

input n: 8
(fact n) = 40320
(total-pushes = 14 maximum-depth = 14)

input n: 9
(fact n) = 362880
(total-pushes = 16 maximum-depth = 16)

input n: 10
(fact n) = 3628800
(total-pushes = 18 maximum-depth = 18)
|#