;;;83-coercion.scm

(load "make-table.scm")

(define (scheme-number->scheme-number n) n)
(define (rational->rational x) x)
(define (complex->complex x) x)

(define coercion-table (make-table))

(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

(put-coercion 'scheme-number 'scheme-number 
              scheme-number->scheme-number)
(put-coercion 'rational 'rational
			  rational->rational)
(put-coercion 'complex 'complex
			  complex->complex)