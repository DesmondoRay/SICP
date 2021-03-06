(load "../Exercise-2.40/p40.scm")

(define (triad-sum-s n s)
  (filter (lambda (x)
            (= (sum-triad x) s))
          (unique-triads n)))

(define (unique-triads n)
  (flatmap (lambda (i)
                 (map (lambda (j)
                          (cons i j))
                      (unique-pairs (- i 1))))
             (enumerate-interval 1 n)))

(define (sum-triad triad)
  (fold-right + 0 triad))

#| test: 
1 ]=> (triad-sum-s 6 10)

;Value 13: ((5 3 2) (5 4 1) (6 3 1))
|#