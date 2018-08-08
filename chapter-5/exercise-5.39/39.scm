;;; exercise 5.39

(define empty-compile-time-env '())

(define (lexical-address frame-address var-address)
  (list frame-address var-address))

(define (lexical-address-lookup lexical-address run-time-env)
  (let* ((frame-address (car lexical-address))
         (var-address (cadr lexical-address))
         (frame (list-ref run-time-env frame-address))
         (value (list-ref frame var-address)))
    (if (eq? value '*unssigned*)
        (error "Unassigned variable! -- LEXICAL-ADDRESS-LOOKUP"
               lexical-address)
        value)))

(define (lexical-address-set! lexical-address run-time-env value)
  (let* ((frame-address (car lexical-address))
         (var-address (cadr lexical-address))
         (frame (list-ref run-time-env frame-address))
         (val (list-ref frame var-address))
         (val-position (member val frame))) 
    (set-car! val-position value)
    'done))

;; test
(define lex-addr-1 (lexical-address 1 1))
(define lex-addr-2 (lexical-address 0 1))

(define frame-1 '(1 (2 3) 4))
(define frame-2 '(a (b c) d))
(define env (list frame-1 frame-2))

#| output:
1 ]=> (lexical-address-lookup lex-addr-1 env)

;Value 13: (b c)

1 ]=> (lexical-address-set! lex-addr-2 env 34)

;Value: done

1 ]=> (lexical-address-lookup lex-addr-2 env)

;Value: 34
|#