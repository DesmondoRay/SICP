;;; 59-b.scm

(load "../exercise-3.59/59-a.scm")
(load "../common/scale-stream.scm")

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (integrate-series 
				  (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

;; test
(newline)
(display (stream-head exp-series 10))
(newline)
(display (stream-head cosine-series 10))
(newline)
(display (stream-head sine-series 10))

; 结果: 
;	(1 1 1/2 1/6 1/24 1/120 1/720 1/5040 1/40320 1/362880)
;	(1 0 -1/2 0 1/24 0 -1/720 0 1/40320 0)
;	(0 1 0 -1/6 0 1/120 0 -1/5040 0 1/362880)

