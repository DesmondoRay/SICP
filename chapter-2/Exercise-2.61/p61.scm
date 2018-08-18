(load "../Exercise-2.61/set-sort.scm")

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set))
         (cons x set))
        (else (cons (car set) 
                    (adjoin-set x (cdr set))))))

#|
1 ]=> (adjoin-set 3 '(1 2 4 5))

;Value 13: (1 2 3 4 5)
|#