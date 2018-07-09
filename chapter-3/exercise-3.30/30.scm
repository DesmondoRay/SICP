;;; 30.scm

(load "../common/simulate.scm")

(define (ripple-carry-adder list-a list-b list-s c)
  (define (iter list-a list-b list-s value-of-c)
	(if (null? list-a)
		'ok
		(let ((ak (car list-a))
			  (bk (car list-b))
			  (sk (car list-s))
			  (rest-a (cdr list-a))
			  (rest-b (cdr list-b))
			  (rest-s (cdr list-s))
			  (ck (make-wire)))
		  (set-signal! ck value-of-c)
		  (full-adder ak bk ck sk c)
		  (iter rest-a rest-b rest-s (get-signal c)))))
  (iter list-a list-b list-s 0))

;; test
(define a1 (make-wire))
(define b1 (make-wire))
(define s1 (make-wire))
(define c (make-wire))

(ripple-carry-adder (list a1) (list b1) (list s1) c)
(propagate)
(display (get-signal c))
(newline)
(display (get-signal s1))
(newline)
(newline)
; 结果:
;	0
;	0

(set-signal! a1 1)
(ripple-carry-adder (list a1) (list b1) (list s1) c)
(propagate)
(display (get-signal s1))
(newline)
(display (get-signal c))
(newline)
(newline)
; 结果:
;	1
;	0

(set-signal! b1 1)
(ripple-carry-adder (list a1) (list b1) (list s1) c)
(propagate)
(display (get-signal s1))
(newline)
(display (get-signal c))
(newline)
(newline)
; 结果:
;	0
;	1

(define a2 (make-wire))
(define b2 (make-wire))
(define s2 (make-wire))
(set-signal! a2 1)
(set-signal! b2 1)
(ripple-carry-adder (list a1 a2) (list b1 b2) (list s1 s2) c)
(propagate)
(display (get-signal s1))
(newline)
(display (get-signal s2))
(newline)
(display (get-signal c))
(newline)
; 结果:
;	0
;	1
;	1

