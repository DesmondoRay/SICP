;;; 48.scm

(load "../common/make-serializer.scm")
(load "../common/exchange.scm")
(load "../common/parallel-execute.scm")
(load "48-serialized-exchange.scm")

(define (make-account balance)
  (let ((id (generate-account-id)))
	(define (withdraw amount)
	  (if (>= balance amount)
		  (begin (set! balance (- balance amount))
				 balance)
		  "Insufficient funds"))
	(define (deposit amount)
	  (set! balance (+ balance amount))
	  balance)
	(let ((balance-serializer (make-serializer)))
	  (define (dispatch m)
		(cond ((eq? m 'withdraw) withdraw)
			  ((eq? m 'deposit) deposit)
			  ((eq? m 'balance) balance)
			  ((eq? m 'serializer) balance-serializer)
			  ((eq? m 'get-id) id)
			  (else (error "Unknown request -- MAKE-ACCOUNT"
						   m))))
	  dispatch)))

;; 帐号的数量
(define (account-counts)
  (let ((counts 0))
	(lambda ()
	  (begin (set! counts (+ counts 1))
			 (- counts 1)))))

;; 生成帐号的id
(define generate-account-id
  (account-counts))

;; test
(define a1 (make-account 100))
(define a2 (make-account 50))
(display (a1 'get-id))
; 输出: 0
(newline)
(display (a2 'get-id))
; 输出: 1
(newline)

(serialized-exchange a1 a2)
(display (a1 'balance))
; 输出: 50
(newline)
(display (a2 'balance))
; 输出: 100
(newline)

