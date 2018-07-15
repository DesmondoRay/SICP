;;; apply.scm

;; 注：将书上的元循环的 apply命名为apply-in-4（顺便将eval也修改为 eval-in-4）
; 虽然我们在定义元循环的apply之前，已经先用下面方式保存了基础qpply的一个引用:
; (define apply-in-underlying-scheme apply)
; 在我们第一次加载程序时，不会出现问题，因为apply-in-underlying-scheme就是apply
; 若是在不关闭mit-scheme的情况下，重新加载一次程序，则会出错，
; 因为现在apply-in-underlying-scheme保存的时我们定义的apply。

(define (apply-in-4 procedure arguments)
  (cond ((primitive-procedure? procedure)
		 (apply-primitive-procedure procedure arguments))
		((compound-procedure? procedure)
		 (eval-sequence
		  (procedure-body procedure)
		  (extend-environment
		   (procedure-parameters procedure)
		   arguments
		   (procedure-environment procedure))))
		(else
		 (error "Unknown procedure type -- APPLY" procedure))))