(load "../Exercise-2.64/p64.scm")

(define (lookup given-key set)
  (if (null? set) 
      false
      (let ((key (entry set)))
        (cond ((equal? given-key key)
			   true)
			  ((< given-key key)
			   (lookup given-key (left-branch set)))
			  ((> given-key key)
			   (lookup given-key (right-branch set)))))))

;; test
(define tree (list->tree '(1 3 4 5 7 8)))

#| output: 
1 ]=> (lookup 5 tree)

;Value: #t

1 ]=> (lookup 6 tree)

;Value: #f
|#