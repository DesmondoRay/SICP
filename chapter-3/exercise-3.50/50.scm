;;; 50.scm

(load "../common/display-stream.scm")
(load "../common/stream-enumerate-interval.scm")

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
	  the-empty-stream
	  (cons-stream
	   (apply proc (map (lambda (s)
						  (stream-car s))
						argstreams))
	   (apply stream-map
			  (cons proc (map (lambda (s)
								(stream-cdr s))
							  argstreams))))))

;; test
(define s1 (stream-enumerate-interval 1 10))
(define s2 (stream-enumerate-interval 1 10))

(define s (stream-map + s1 s2))
(display-stream s)

#|输出:
	2
	4
	6
	8
	10
	12
	14
	16
	18
	20
|#
