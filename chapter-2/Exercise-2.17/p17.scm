(define (last-pair items)
  (let ((n (- (length items) 1)))
    (list-ref items n)))

#| test
1 ]=> (last-pair (list 23 72 149 34))

;Value: 34
|#