;;; 6.scm

(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define (rand-internal init-value)
  (let ((x init-value))
	(lambda (symbol)
	  (cond ((eq? symbol 'generate)
			 (set! x (rand-update x))
		     x)
		    ((eq? symbol 'reset)
		     (lambda (new-value)
			   (set! x new-value)))
		    (else
		     (error "Unknown request -- RAND" 
					symbol))))))

;; test
(define rand (rand-internal 100))
(newline)
(display (rand 'generate))
(newline)
(display (rand 'generate))
(newline)
(display (rand 'generate))
(newline)
(newline)
((rand 'reset) 100)
(display (rand 'generate))
(newline)
(display (rand 'generate))
(newline)
(display (rand 'generate))

;; 结果输出:
;	59
;	95
;	51
;
;	59
;	95
;	51

