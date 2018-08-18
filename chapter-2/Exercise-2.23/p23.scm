(define (for-each proc items)
  (cond ((null? items) true)
        (else 
         (proc (car items))
         (for-each proc (cdr items)))))

#| test: 
1 ]=> (for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

57
321
88
;Value: #t
|#