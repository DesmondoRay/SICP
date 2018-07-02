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

(reverse (list (list 1 2) (list 3 4)))
(reverse-deep (list (list 1 2) (list 3 4)))
