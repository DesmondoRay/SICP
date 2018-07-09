;;; 31.scm
;;; 去掉(proc)

(load "simulate.scm")

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

;; test
(probe 'sum sum)
;value: ()
(probe 'carry carry)
;value: ()
(half-adder input-1 input-2 sum carry)
;value: ok

(set-signal! input-1 1)
;value: done
(propagate)
;value: done

(set-signal! input-2 1)
;value: done
(propagate)
; carry 11  New-value = 1
;value: done