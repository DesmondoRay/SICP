;;; 76.scm

(define (smooth input-stream)
  (stream-map (lambda (a b) (/ (+ a b) 2))
			  input-stream 
			  (stream-cdr input-stream)))

(define (make-zero-crossings input-stream)
  (let ((smooth-stream (smooty input-stream)))
	(stream-map sign-change-detector
				smooth-stream
				(stream-cdr smooth-stream))))

;; 注: 根据74题，可能需要在sense-data前加一个0；
;; 为了函数的通用性，在定义中不做添加0的操作，可在传入参数时添加。

