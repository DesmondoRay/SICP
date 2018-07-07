;;; 2.scm

(define (make-monitored proc)
  (let ((count 0))
	(lambda (x)
	  (cond ((eq? x 'how-many-calls?) count)
			((eq? x 'reset-count) (set! count 0))
			(else
			 (begin (set! count (+ count 1))
					(proc x)))))))

;; test
(define s (make-monitored sqrt))

(newline)
(display (s 100))
(newline)
(display (s 'how-many-calls?))
(newline)
(s 'reset-count)
(display (s 'how-many-calls?))

;; 测试结果:
;	10
;	1
;	0