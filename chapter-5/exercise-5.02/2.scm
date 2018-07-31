;;; exercise 5.2

(controller
 (assign product (const 1))
 (assign count (const 1))
 
 test-count
 (test (op >) (reg count) (reg n))
 (branch (label fact-done))
 (assign t1 (op *) (reg product) (reg count))
 (assign t2 (op +) (reg c) (const 1))
 (assign product (reg t1))
 (assign count (reg t2))
 (goto (label test-count))
fact-done)