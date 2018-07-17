;;; 3.scm

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? p password)
        (begin 
         (cond ((eq? m 'withdraw) withdraw)
               ((eq? m 'deposit) deposit)
               (else 
                (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
        (lambda (amount)
          (display "Incorrect password: ")
          p)))
  dispatch)

;; test
(define acc (make-account 100 '123456))
(newline)
(display ((acc '123456 'withdraw) 40))
(newline)
(display ((acc 'abcdef 'deposit) 50))
(newline)
(display ((acc '123456 'deposit) 50))
(newline)

;; 结果:
;   60
;   Incorrect password: abcdef
;   110
