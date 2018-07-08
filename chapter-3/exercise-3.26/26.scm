;;; 26.scm

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
		((= (car x) (car (entry set))) set)
		((< (car x) (car (entry set)))
		 (make-tree (entry set)
					(adjoin-set x (left-branch set))
					(right-branch set)))
		((> (car x) (car (entry set)))
		 (make-tree (entry set)
					(left-branch set)
					(adjoin-set x (right-branch set))))))

(define (lookup given-key set)
  (if (null? set) 
	  false
	  (let ((key (car (entry set))))
		(cond ((= given-key key)
			   (cdr (car set)))
			  ((< given-key key)
			   (lookup given-key (left-branch set)))
			  ((> given-key key)
			   (lookup given-key (right-branch set)))))))


;; test
(define table (adjoin-set (cons 3 'a) '()))
(set! table (adjoin-set (cons 4 'b) table))
(set! table (adjoin-set (cons 2 'c) table))
(set! table (adjoin-set (cons 1 'd) table))

(newline)
(display (lookup 2 table))
(newline)
; 结果: c
(display (lookup 3 table))
(newline)
; 结果: a

