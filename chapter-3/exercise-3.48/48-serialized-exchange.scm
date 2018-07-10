;;; 48-serialized-exchange.scm

(define (serialized-exchange account1 account2)
  (if (< (account1 'get-id) (account2 'get-id))
	  (let ((serializer1 (account1 'serializer)))
		(let ((serializer2 (account2 'serializer)))
		  ((serializer1 (serializer2 exchange))
		   account1
		   account2)))
	  (let ((serializer2 (account2 'serializer)))
		(let ((serializer1 (account1 'serializer)))
		  ((serializer1 (serializer2 exchange))
		   account1
		   account2)))))