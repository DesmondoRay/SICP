(load "p29-a.scm")

(define (total-weight m)
  (cond ((null? m) 0)
        ((not (pair? m))
         m)
        (else (+ (total-weight
                  (branch-structure (left-branch m)))
                 (total-weight
                  (branch-structure (right-branch m)))))))
