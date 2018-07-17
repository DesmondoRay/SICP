;;; 16.scm

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; test
; count-pairs = 3
(define one (cons 1 '()))
(define same-one (cons 1 '()))
(define three (cons one same-one))
(newline)
(display (count-pairs three))
; 输出: 3

; count-pairs = 4
(define two (cons 1 one))
(define four (cons two one))
(newline)
(display (count-pairs four))
; 输出: 4

; count-pairs = 7
(define same-three (cons one one))
(define seven (cons same-three same-three))
(newline)
(display (count-pairs seven))
; 输出: 7

; count-pairs无返回结果
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define d (make-cycle three))
(newline)
(display (count-pairs d))
; 输出: 
;   ... aborted

