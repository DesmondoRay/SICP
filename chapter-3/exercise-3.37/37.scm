;;; 37.scm

(load "../common/adder.scm")
(load "../common/multiplier.scm")
(load "../common/constant.scm")
(load "../common/make-connector.scm")
(load "../common/inform-about-value.scm")
(load "../common/probe-3.3.5.scm")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c- x y)
  (let ((z (make-connector)))
    (adder y z x)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier y z x)
    z))

(define (cv value)
  (let ((cv (make-connector)))
    (constant value cv)
    cv))

;; test
(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)
; 输出:
;   Probe: Celsius temp = 25
;   Probe: Fahrenheit temp = 77

(forget-value! C 'user)
; 输出:
;   Probe: Celsius temp = ?
;   Probe: Fahrenheit temp = ?

(set-value! F 212 'user)
; 输出:
;   Probe: Fahrenheit temp = 212
;   Probe: Celsius temp = 100

(set-value! C 50 'user)
;Contradiction (100 50)

