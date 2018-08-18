(define (reverse items)
  (reverse-n items (- (length items) 1)))

(define (reverse-n items n)
  (if (= n -1)
      '()
      (cons (list-ref items n)
            (reverse-n items (- n 1)))))

#| test:
1 ]=> (reverse (list 1 4 9 16 25))

;Value 13: (25 16 9 4 1)
|#
    