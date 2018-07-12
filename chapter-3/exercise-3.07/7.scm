;;; 7.scm

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
			   ((eq? m 'confirm-password)
				#t)
			   (else 
				(error "Unknown request -- MAKE-ACCOUNT"
					   m))))
		(lambda (amount)
		  (display "Incorrect password: ")
		  p)))
  dispatch)

(define (make-joint account-1 password-1 password-2)
  (if (account-1 password-1 'confirm-password)
	  (lambda (input-password request)
		(if (eq? input-password password-2)
			(account-1 password-1 request)
			(lambda (amount)
			  (display "Incorrect password (joint account): ")
			  input-password)))))

;; test
(define peter-acc (make-account 100 '123456))
(define paul-acc
  (make-joint peter-acc '123456 'abcdef))
(newline)
(display ((peter-acc '123456 'withdraw) 40))
(newline)
(display ((paul-acc 'abcdef 'withdraw) 10))
(newline)
(display ((paul-acc 'aaaaaa 'withdraw) 10))
(newline)
(display ((peter-acc '123456 'deposit) 10))

;; 结果:
;	60
;	50
;	Incorrect password (joint account): aaaaaa
;	60

