;;; exercise-4.scm

(define (a-plus-abs-b a b)
  ((if (> b 0) 
       + 
       -)
   a b))

;; 改写成上述样式，对 if 过程求值，当 b>0 时返回 + 过程，
;; b <= 0 时，返回 - 过程，将 a 和 b 作为参数调用 + 或 - 过程，
;; 也就是求 a 和 b 绝对值的和。

;; test
(a-plus-abs-b 3 -4)
; 结果: 7

