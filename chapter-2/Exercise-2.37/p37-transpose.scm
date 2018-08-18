(load "p37-vector.scm")

(define (transpose mat)
  (accumulate-n cons '() mat))

(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(transpose m)
