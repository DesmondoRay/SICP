;;; 68.scm

(load "../common/integers.scm")
(load "../common/interleave.scm")

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
			   t)
   (pairs (stream-cdr s) (stream-cdr t))))

;; test
(define s (pairs integers integers))

(stream-head s 10)
;Aborting!: maximum recursion depth exceeded
; 超出最大递归深度

;; 原因：因为lisp采用应用序求值，在调用过程时会对参数求值，调用(pairs s t)，
;; 得到interleave过程，再对(pairs (stream-cdr s) (stream-cdr t))求值，
;; 如此往复，造成无限循环。