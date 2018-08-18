(define (reverse-deep items)
  (reverse-n-deep items (- (length items) 1)))

(define (reverse-n-deep items n)
  (if (= n -1)
      '()
      (cons (element-reverse items n)
            (reverse-n-deep items (- n 1)))))

(define (element-reverse items n)
  (let ((item (list-ref items n)))
    (if (pair? item)
        (reverse-n-deep item (- (length item) 1))
        item)))

#|
1 ]=> (reverse (list (list 1 2) (list 3 4)))

;Value 13: ((3 4) (1 2))

1 ]=> (reverse-deep (list (list 1 2) (list 3 4)))

;Value 14: ((4 3) (2 1))
|#