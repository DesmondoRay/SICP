;;; 81.scm

(define (random-update x) 
         (remainder (+ (* 13 x) 5) 24))

;; 初始随机数
(define rand-init 12)

(define (random-generator request-stream)
  (define (random-number num rest-requests)
	(let ((first-request (stream-car rest-requests)))
	  (cond ((eq? first-request 'generate)
			 (cons-stream num
						  (random-number (random-update num)
										 (stream-cdr rest-requests))))
			((pair? first-request)
			 (if (eq? (car first-request) 'reset)
				 (cons-stream (cdr first-request)
							  (random-number (random-update (cdr first-request))
											 (stream-cdr rest-requests)))
				 (error "Unknown request -- RANDOM-GENERATOR"
						first-request)))
			(else 
			 (error "Unknown request -- RANDOM-GENERATOR"
					first-request)))))
  (random-number rand-init request-stream))


;; test
; 生成操作流
(define requests
  (cons-stream 'generate 
			   (cons-stream 'generate
							(cons-stream (cons 'reset 10)
										 (cons-stream 'generate
													  (cons-stream 'generate
																   'generate))))))
; 生成随机数流
(define randoms (random-generator requests))

(load "../common/display-stream.scm")
(display-stream randoms)

#| output:
12
17
10
15
8
|#