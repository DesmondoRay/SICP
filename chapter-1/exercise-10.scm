;;; exercise 1.10

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(newline)
(display (A 1 10))
(newline)
(display (A 2 4))
(newline)
(display (A 3 3))
; 输出:
;   1024
;   65536
;   65536

;; 给出下列f, g, h, k 的数学定义
(define (f n) (A 0 n))  ; --> 2 * n
(define (g n) (A 1 n))  ; --> 2 ^ n
(define (h n) (A 2 n))  ; --> 2 ^ 2 ^ 2 ^ ... 2 ^ 2; n 个 2
(define (k n) (* 5 n n))  ; --> 5 * n^2