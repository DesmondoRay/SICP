(load "../common/2-2-3.scm")

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (sub-tree)
                     (if (pair? sub-tree)
                         (count-leaves sub-tree)
                         1))
                   t)))

#| test:
1 ]=> (count-leaves (list 1 2 (list 3 4)))

;Value: 4
|#