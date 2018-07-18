;;; exercise 4.21 b)

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))

#|
;; test
1 ]=> (f 4)

;Value: #t

1 ]=> (f 3)

;Value: #f

1 ]=> (f 2)

;Value: #t

1 ]=> (f 1)

;Value: #f

1 ]=> (f 0)

;Value: #t
|#