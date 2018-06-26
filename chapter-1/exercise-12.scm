;;; exercise 1.12

(define (print r c)
  (if (or (= c 1) (= r c))
      1
      (+ (print (- r 1) (- c 1))
         (print (- r 1) c))))

(print 5 1)
(print 5 2)
(print 5 3)
(print 5 4)
(print 5 5)