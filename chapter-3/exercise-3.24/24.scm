;;; 24.scm

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
	(define (lookup key-1 key-2)
  	  (let ((subtable (assoc-same-key? key-1 (cdr local-table))))
		(if subtable
			(let ((record (assoc-same-key? key-2 (cdr subtable))))
			  (if record
			 	 (cdr record)
			 	 false))
			false)))
	(define (insert! key-1 key-2 value)
 	  (let ((subtable (assoc-same-key? key-1 (cdr local-table))))
	    (if subtable
			(let ((record (assoc-same-key? key-2 (cdr subtable))))
		 	 (if record
				 (set-cdr! record value)
			     (set-cdr! subtable
						   (cons (cons key-2 value)
							     (cdr subtable)))))
			 (set-cdr! local-table
				  	   (cons (list key-1
							       (cons key-2 value))
						     (cdr local-table)))))
	  'ok)
	
	;; 使用same-key?检查关键码是否相等
	(define (assoc-same-key? key records)
	  (cond ((null? records) false)
			((same-key? key (caar records)) 
			 (car records))
			(else
			 (assoc-same-key? key (cdr records)))))
  (define (dispatch m)
	(cond ((eq? m 'lookup) lookup)
		  ((eq? m 'insert!) insert!)
		  (else (error "Unknown opeartion -- TABLE" m))))
  dispatch))


;; test
; 若key-1和key-2之差的绝对值小于或等于0.05,则判定它们相等
(define (same-key? key-1 key-2)
  (<= (abs (- key-1 key-2)) 0.05))

(define table (make-table same-key?))
((table 'insert!) 1 1.05 100)

(newline)
; abs(1.05-1.02) < 0.05 ，可在表格内找到相应的值
(display ((table 'lookup) 1 1.02))
(newline)
; abs(1.05-1.3) > 0.05，在表格内找不到相应的值
(display ((table 'lookup) 1 1.3))
(newline)
; 结果:
;	100
;	#f

; abs(1.05-1.07) < 0.05, 将表格内相应的值100改为200
((table 'insert!) 1 1.07 200)
(display ((table 'lookup) 1 1.05))
(newline)
(display ((table 'lookup) 1 1.0))
(newline)
; 结果:
;	200
;	#f

