;;; 47.scm
;;; 注: 此测试需要在DrRacket中进行

#lang racket
(require sicp)

(define (make-mutex n)
  (let ((cell (list 0 n)))
	(define (the-mutex m)
	  (cond ((eq? m 'acquire)
			 (if (test-and-set! cell)
				 (the-mutex 'acquire)
				 'acquire-done))
			((eq? m 'release) (clear! cell))))
	the-mutex))

(define (clear! cell)
  (if (= 0 (car cell))
	  'done
	  (set-car! cell (- (car cell) 1))))

(define (test-and-set! cell)
  (if (>= (car cell) (cadr cell))
	  true
	  (begin (set-car! cell (+ 1 (car cell)))
			 false)))

;; parallel-execute-racket.scm
;; 这个parallel-execute过程在DrRacket中才能正常工作
(define (parallel-execute . procs)
  (map thread-wait
       (map (lambda (proc) (thread proc))
            procs)))

;; test
(define a (make-mutex 2))

(a 'acquire)
(a 'acquire)

(parallel-execute (lambda ()
                    (newline)
                    (display "(a 'acquire) start")
                    (newline)
                    (display "waiting...")
                    (newline)
                    (a 'acquire)
                    (display "(a 'acquire) done")
                    (newline))
				  
                  (lambda ()
                    (sleep 10)
                    (a 'release)))

#| 输出:
	'acquire-done
	'acquire-done
	(a 'acquire) start
	waiting...
; 等待10s后:
	(a 'acquire) done
|#

