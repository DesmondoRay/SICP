;;; 4.scm

(define (make-account balance password)
  (let ((wrong-password-times 3))
    (define (withdraw amount)
	  (if (>= balance amount)
		  (begin (set! balance (- balance amount))
			     balance)
		  "Insufficient funds"))
  
    (define (deposit amount)
	  (set! balance (+ balance amount))
	  balance)
	
	(define (call-the-cops)
	  (error "calling the cops!"))
	
    (define (dispatch p m)
	  (if (eq? p password)
		  (begin 
		   (cond ((eq? m 'withdraw) withdraw)
			     ((eq? m 'deposit) deposit)
			     (else 
				  (error "Unknown request -- MAKE-ACCOUNT"
					     m))))
		  (lambda (amount)
			(set! wrong-password-times 
				  (- wrong-password-times 1))
			(if (= 0 wrong-password-times)
				(call-the-cops)
				(begin (display "Incorrect password: ")
					   p)))))
    dispatch))

;; 测试，为了测试简单，将错误次数改为3次
(define acc (make-account 100 '123456))
(newline)
(display ((acc '123456 'withdraw) 40))
(newline)
(display ((acc 'abcdef 'deposit) 50))
(newline)
(display ((acc 'abcdef 'deposit) 50))
(newline)
(display ((acc 'abcdef 'deposit) 50))
(newline)

;; 结果:
;	60
;	Incorrect password: abcdef
;	Incorrect password: abcdef
;	;calling the cops!
