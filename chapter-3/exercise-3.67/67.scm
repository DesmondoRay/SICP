;;; 67.scm

(load "../common/integers.scm")
(load "../common/interleave.scm")

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (interleave (stream-map (lambda (x) (list (stream-car s) x))
                            (stream-cdr t))
                (stream-map (lambda (x) (list x (stream-car t)))
                            (stream-cdr s)))
    (pairs (stream-cdr s) (stream-cdr t)))))

;; test
(define s (pairs integers integers))

(define (before s l)
  (if (not (equal? (stream-car s) l))
      (cons-stream (stream-car s)
                   (before (stream-cdr s) l))
      '()))

(define before-5-5 (before s '(5 5)))
(display (length (stream->list before-5-5)))
;; 结果: 30
(newline)
(newline)
(display (stream->list before-5-5))

#|
((1 1) (1 2) (2 2) (2 1) (2 3) (1 3) 
 (3 3) (3 1) (3 2) (1 4) (3 4) (4 1) 
 (2 4) (1 5) (4 4) (5 1) (4 2) (1 6) 
 (4 3) (6 1) (2 5) (1 7) (4 5) (7 1) 
 (5 2) (1 8) (3 5) (8 1) (2 6) (1 9))
|#
;; 生成顺序见67.md

