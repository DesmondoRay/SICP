;;; exercise 5.3

;; 假设good-enough?和improve都是可用的基本操作
(controller
 (assign x (op read))
 (assign guess (const 1.0))
 
 test-guess
 (test (op good-enough?) (reg guess) (reg x))
 (branch (label done))
 (assign t (op improve) (reg guess) (reg x))
 (assign guess (reg t))
 (goto (label test-guess))
 done
 (perform (op print) (reg guess)))


;; 基于算术操作展开good-enough?和improve
(controller
 (assign x (op read))
 (assign guess (const 1.0))
 
 test-guess
 ; good-enough?
 (assign square (op *) (reg guess) (reg guess))
 (assign diff (op -) (reg square) (reg x))
 (test (op <) (reg diff) (const 0))
 (branch (label test-abs))
 (assign abs (reg diff)) ; positive
 test-abs
 (assign abs (op -) (const 0) (reg diff)) ; negative
 (test (op <) (reg abs) (const 0.001))
 
 (branch (label done))
 
 ; improve procedure
 (assign div (op /) (reg x) (reg guess))
 ; average
 (assign sum (op +) (reg guess) (reg div))
 (assign average (op /) (reg sum) (const 2))
 
 (assign guess (reg average))
 (goto test-guess)
 done
 (perform (op print) (reg guess)))