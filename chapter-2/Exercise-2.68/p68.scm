(load "p67.scm")
(load "p68-element-of-set?.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (let ((left (left-branch tree))
            (right (right-branch tree)))
        (if (element-of-set? symbol (symbols left))
            (cons 0
                  (encode-symbol symbol left))
            (cons 1
                  (encode-symbol symbol right))))))
             