;;; ambeval-and-or.scm

(ambeval '(define (and p1 p2)
            (if p1
                (if p2
                    true
                    false)
                false))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (or p1 p2)
            (if p1
                true
                (if p2
                    true
                    false)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
            