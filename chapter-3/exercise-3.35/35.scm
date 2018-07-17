;;; 35.scm

(load "../common/adder.scm")
(load "../common/multiplier.scm")
(load "../common/constant.scm")
(load "../common/make-connector.scm")
(load "../common/inform-about-value.scm")
(load "../common/probe-3.3.5.scm")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            (set-value! a (sqrt (get-value b)) me))
        (if (has-value? a)
            (set-value! b (square (get-value a)) me)
            false)))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me)
  me)

;; test
(define a (make-connector))
(define b (make-connector))

(squarer a b)
(probe "a" a)
(probe "b" b)

(set-value! a 4 'user)
; 输出:
;   Probe: a = 4
;   Probe: b = 16

(forget-value! a 'user)
; 输出:
;   Probe: a = ?
;   Probe: b = ?

(set-value! b 25 'user)
; 输出:
;   Probe: b = 25
;   Probe: a = 5

(set-value! a 3 'user)
;Contradiction (5 3)

