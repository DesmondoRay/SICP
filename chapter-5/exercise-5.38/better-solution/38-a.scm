;;; exercise 5.38 a)

(define all-arg-regs '(arg1 arg2))
(define total-arg-regs (length all-arg-regs))

(define (spread-arguments operands-list)
  (define (iter operands-list arg-regs)
    (if (null? operands-list)
        (empty-instruction-sequence)
        (let ((rest-seq (iter (cdr operands-list)
                              (cdr arg-regs)))
              (first-seq (compile (car operands-list)
                                  (car arg-regs)
                                  'next)))
          (preserving
           '(env)
           rest-seq
           (preserving (cdr arg-regs)
                       first-seq
                       (make-instruction-sequence
                        (cdr arg-regs)
                        '()
                        '()))))))
  (iter operands-list (take all-arg-regs (length operands-list))))