(define x (list 1 3 (list 5 7) 9))
(define y (list (list 7)))
(define z (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

#| output:
1 ]=> (car (cdaddr x))

;Value: 7

1 ]=> (car (car y))

;Value: 7

1 ]=> (cadadr (cadadr (cadadr z)))

;Value: 7
|#