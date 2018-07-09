;;; 29.scm

(define (or-gate a1 a2 output)
  (let ((not-a1 (make-wire))
		(not-a2 (make-wire))
		(and-not-out (make-wire)))
	(inverter a1 not-a1)
	(inverter a2 not-a2)
	(and-gate not-a1 not-a2 and-not-out)
	(inverter and-not-out output))
  'ok)
