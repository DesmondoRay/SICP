(define (reverse-right sequence)
  (fold-right (lambda (x y)
                (append y (list x)))
              '()
              sequence))

(define (reverse-left sequence)
  (fold-left (lambda (x y)
               (cons y x))
             '()
             sequence))

;; test
(newline)
(display (reverse-right (list 1 2 3)))
(newline)
(display (reverse-left (list 1 2 3)))

#| output:
(3 2 1)
(3 2 1)
|#