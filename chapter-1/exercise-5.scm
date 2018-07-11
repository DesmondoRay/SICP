;;; exercise-5.scm

(define (p) (p))

(define (test x y)
  (if (= x 0)
	  0
	  y))

;; 应用序求值: 调用(test 0 (p)) 进入无限循环;
;; 正则序求值: 返回0

;; test
(test 0 (p))
; 进入无限循环
; 调用(p)过程，返回(p)

; lisp采用应用序求值，部分原因在于这样做能避免对于表达式的重复求值，从而提高一些效率。
