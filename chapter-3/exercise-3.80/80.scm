;;; 80.scm

(load "../exercise-3.78/integral-delay.scm")
(load "../common/scale-stream.scm")
(load "../common/add-streams.scm")

(define (RLC R C L dt)
	(define (vc-il vc0 il0)
	  (define vc (integral (delay dvc) vc0 dt))
	  (define il (integral (delay dil) il0 dt))
	  (define dvc (scale-stream il (/ -1 C)))
	  (define dil (add-streams (scale-stream vc (/ 1 L))
							   (scale-stream il (- (/ R L)))))
	  (stream-map cons vc il)) ; vc 和 il 为 stream
	vc-il)

;; test
(define RLC1 (RLC 1 0.2 1 0.1))
(define vc-il (RLC1 10 0))
(stream-head vc-il 10)
#| 结果:
((10 . 0) 
 (10 . 1.) 
 (9.5 . 1.9) 
 (8.55 . 2.66) 
 (7.220000000000001 . 3.249) 
 (5.5955 . 3.6461) 
 (3.77245 . 3.84104) 
 (1.8519299999999999 . 3.834181) 
 (-.0651605000000004 . 3.6359559) 
 (-1.8831384500000004 . 3.2658442599999997))
|#