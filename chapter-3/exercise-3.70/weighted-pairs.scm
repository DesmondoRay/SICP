;;; weighted-pairs.scm

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
	(stream-map (lambda (x) (list (stream-car s) x))
				(stream-cdr t))
	(weighted-pairs (stream-cdr s) (stream-cdr t) weight)
	weight)))