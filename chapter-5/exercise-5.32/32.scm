;;; exercise 5.32

;; a)
ev-application 
  (save continue) 
  (assign unev (op operands) (reg exp)) 
  (assign exp (op operator) (reg exp)) 
  (test (op symbol?) (reg exp))                    ; exercise 5.32 ******
  (branch (label ev-appl-operator-symbol)) 
  (save env) 
  (save unev) 
  (assign continue (label ev-appl-did-operator)) 
  (goto (label eval-dispatch)) 
ev-appl-operator-symbol  ; 不保存env和unev
  (assign continue (label ev-appl-did-operator-symbol)) 
  (goto (label eval-dispatch)) 
ev-appl-did-operator 
  (restore unev)             
  (restore env) 
ev-appl-did-operator-symbol
  (assign argl (op empty-arglist)) 
  (assign proc (reg val))     ; the operator 
  (test (op no-operands?) (reg unev)) 
  (branch (label apply-dispatch)) 
  (save proc)
; the following part is the same as before
ev-appl-operand-loop
  (save argl)
  (assign exp (op first-operand) (reg unev))
  (test (op last-operand?) (reg unev))
  (branch (label ev-appl-last-arg))
  (save env)
  (save unev)
  (assign continue (label ev-appl-accumulate-arg))
  (goto (label eval-dispatch))
ev-appl-accumulate-arg
  (restore unev)
  (restore env)
  (restore argl)
  (assign argl (op adjoin-arg) (reg val) (reg argl))
  (assign unev (op rest-operands) (reg unev))
  (goto (label ev-appl-operand-loop))
ev-appl-last-arg
  (assign continue (label ev-appl-accum-last-arg))
  (goto (label eval-dispatch))
ev-appl-accum-last-arg
  (restore argl)
  (assign argl (op adjoin-arg) (reg val) (reg argl))
  (restore proc)
  (goto (label apply-dispatch))
apply-dispatch
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-apply))
  (test (op compound-procedure?) (reg proc))  
  (branch (label compound-apply))
  (goto (label unknown-procedure-type))

;; b) 如401页所述，虽然像类似于preserving的过程能够提升编译后程序运行速度，
; 但是preserving过程本身是需要耗费时间的，
; 所以对于解释器而言，在求值器里识别出更多编译器里的特殊情况，不一定能提升解释器的效率。