;;; 33.scm

(load "../common/adder.scm")
(load "../common/multiplier.scm")
(load "../common/constant.scm")
(load "../common/make-connector.scm")
(load "../common/inform-about-value.scm")
(load "../common/probe-3.3.5.scm")

(define (average a b c)
  (let ((sum (make-connector))
		(two (make-connector)))
	(constant 2 two)
	(adder a b sum)
	(multiplier two c sum)
	'ok))

;; test
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(average a b c)

(probe "a" a)
(probe "b" b)
(probe "c" c)

(set-value! a 10 'user)
(set-value! b 6 'user)
(set-value! c 1 'user)

; 输出:
;	Probe: a = 10
;	Probe: b = 6
;	Probe: c = 8
;	;Contradiction (8 1)

; 终端输入:
(forget-value! a 'user)
; 输出:
;	Probe: a = ?
;	Probe: c = ?

(set-value! c 5 'user)
; 输出:
;	Probe: c = 5
;	Probe: a = 4

