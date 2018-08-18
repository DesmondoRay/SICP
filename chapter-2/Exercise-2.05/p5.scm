(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car z)
  (cond ((= 1 z) 0)
        ((= (remainder z 3) 0)
         (car (/ z 3)))
        (else (+ 1 (car (/ z 2))))))

(define (cdr z)
  (cond ((= 1 z) 0)
        ((= (remainder z 2) 0)
         (cdr (/ z 2)))
        (else (+ 1 (cdr (/ z 3))))))

#| test: 
1 ]=> (car 6)

;Value: 1

1 ]=> (car 12)

;Value: 2

1 ]=> (car 24)

;Value: 3

1 ]=> (cdr 6)

;Value: 1

1 ]=> (cdr 18)

;Value: 2

1 ]=> (cdr 54)

;Value: 3
|#