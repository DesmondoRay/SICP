;;; 18.scm

;; 判断x(整个list)是否为环，即首尾相接的情况
(define (cycle?-whole x)
  (define (cycle?-internal x check-list)
    (if (not (pair? x))
        #f
        (if (in-list check-list x)
            #t
            (begin (set! check-list (cons x check-list))
                   (cycle?-internal (cdr x) check-list)))))
  (cycle?-internal x '()))

;; 判断x内是否包含环(包括x本身为环的情况)
(define (cycle? x)
  (if (or (null? x) (not (pair? x)))
      #f
      (or (cycle?-whole x)
          (cycle?-whole (car x))
          (cycle?-whole (cadr x)))))

;; 判断x是否在表l内
(define (in-list l x)
  (cond ((null? l) #f)
        ((eq? (car l) x)
         #t)
        (else
         (in-list (cdr l) x))))

;; test1: x本身为环
(define x '(a b c))
(newline)
(display (cycle? x))
(newline)
(display (cycle? (append! x x)))
(newline)
; 输出：
;   #f
;   #t

;; test2: y包含一个环
(define y1 '(b c))
(define y (list 'a y1))
(set-cdr! (last-pair y1) y1)
(display (cycle? y))
; 输出：
;   #t

