(define (last-pair items)
  (let ((n (- (length items) 1)))
    (list-ref items n)))

(last-pair (list 23 72 149 34))