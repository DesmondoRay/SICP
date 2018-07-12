;;; 66.scm

(load "../common/integers.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
	  s2
	  (cons-stream (stream-car s1)
				   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
	(stream-map (lambda (x) (list (stream-car s) x))
				(stream-cdr t))
	(pairs (stream-cdr s) (stream-cdr t)))))

;; test
(define s (pairs integers integers))

(define (before-1-100 s l)
  (if (not (equal? (stream-car s) l))
	  (cons-stream (stream-car s)
				   (before-1-100 (stream-cdr s) l))
	  '()))

(define before (before-1-100 s '(1 100)))
(display (length (stream->list before)))
(newline)
(newline)
(display (stream->list before))