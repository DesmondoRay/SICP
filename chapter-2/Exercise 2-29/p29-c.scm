(load "p29-b.scm")

(define (balance? m)
  (if (pair? m)
      (let ((left-st (branch-structure (left-branch m)))
            (right-st (branch-structure (right-branch m))))
        (and (balance? left-st)
             (balance? right-st)
             (= (* (left-weight m) (branch-length (left-branch m)))
                (* (right-weight m) (branch-length (right-branch m))))))
      true))

(define (left-weight m)
  (let ((left-st (branch-structure (left-branch m))))
    (if (pair? left-st)
        (total-weight left-st)
        left-st)))

(define (right-weight m)
  (let ((right-st (branch-structure (right-branch m))))
    (if (pair? right-st)
        (total-weight right-st)
        right-st)))