(load "set-tree.scm")

(define (lookup given-key set)
  (if (null? set) 
	  false
	  (let ((key (given-key (entry set))))
		((equal? given-key key)
		 (car set))
		((< given-key key)
		 (lookup given-key (left-branch set)))
		((> given-key key)
		 (lookup given-key (right-branch set))))))