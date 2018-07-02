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

(car 6)
(car 12)
(car 24)

(cdr 6)
(cdr 18)
(cdr 54)
