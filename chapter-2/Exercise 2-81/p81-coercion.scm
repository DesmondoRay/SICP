;;;p81-coercion.scm

(load "make-table.scm")

(define (scheme-number->scheme-number n) n)

(define coercion-table (make-table))

(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

(put-coercion 'scheme-number 'scheme-number 
              scheme-number->scheme-number)