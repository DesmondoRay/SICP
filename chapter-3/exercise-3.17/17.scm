;;; 17.scm

(define (in-list l x)
  (cond ((null? l) #f)
        ((eq? (car l) x)
         #t)
        (else
         (in-list (cdr l) x))))

(define (count-pairs x)
  (define (internal x counted-list)
    (cond ((not (pair? x)) 0)
          ((in-list counted-list x)
           0)
          (else
           (+ (internal (car x) (append counted-list (car x)))
              (internal (cdr x) (append counted-list (cdr x)))
              1))))
  (internal x '()))

;; test
(define one (cons 1 '()))
(define same-one (cons 1 '()))
(define three (cons one same-one))
(newline)
(display (count-pairs three))
; 输出: 3

(define two (cons 1 (cons 2 '())))
(define four (cons two (cadr two)))
(newline)
(display (count-pairs four))
; 输出: 3

(define same-three (cons one one))
(define seven (cons same-three same-three))
(newline)
(display (count-pairs seven))
; 输出: 3