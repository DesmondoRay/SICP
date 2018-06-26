(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))


(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))