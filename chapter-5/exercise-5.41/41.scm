;;; exercise 5.41

(define (find-variable var ct-env)
  (let ((lexical-address (list 0 0)))
    (define (find-inner rest-env)
      (if (null? rest-env)
          'not-found
          (let* ((first-frame (car rest-env))
                 (var-position (member var first-frame)))
            (if var-position
                (begin
                 (set-car! (cdr lexical-address)
                           (- (length first-frame) 
                              (length var-position)))
                 lexical-address)
                (begin
                 (set-car! lexical-address
                           (+ 1 (car lexical-address)))
                 (find-inner (cdr rest-env)))))))
    (find-inner ct-env)))

#| test
1 ]=> (find-variable 'c '((y z) (a b c d e) (x y)))

;Value 13: (1 2)

1 ]=> (find-variable 'x '((y z) (a b c d e) (x y)))

;Value 14: (2 0)

1 ]=> (find-variable 'w '((y z) (a b c d e) (x y)))

;Value: not-found
|#