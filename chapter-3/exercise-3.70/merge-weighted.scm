;;; merge-weighted.scm

(define (merge-weighted s t weight)
  (cond ((stream-null? s) t)
		((stream-null? t) s)
		(else
		 (let ((scar (stream-car s))
			   (tcar (stream-car t)))
		   (cond ((< (weight scar) (weight tcar))
				  (cons-stream scar (merge-weighted (stream-cdr s) t weight)))
				 ((> (weight scar) (weight tcar))
				  (cons-stream tcar (merge-weighted s (stream-cdr t) weight)))
				 (else
				  (cons-stream scar
							   (merge-weighted (stream-cdr s)
											   t
											   weight))))))))