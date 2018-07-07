;;; 12.scm

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
(newline)
(display (cdr x))
(newline)
(define w (append! x y))
(display (cdr x))

#|
输出结果：
  (b)
  (b c d)
|#