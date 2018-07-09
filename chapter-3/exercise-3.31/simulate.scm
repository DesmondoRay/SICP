;;; simulate.scm
;;; page 194

(load "make-wire.scm")
(load "../common/or-gate.scm")
(load "../common/and-gate.scm")
(load "../common/inverter.scm")
(load "../common/full-adder.scm")
(load "../common/half-adder.scm")
(load "../common/after-delay.scm")
(load "../common/agenda.scm")
(load "../common/probe.scm")
(load "../common/propagate.scm")


(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)