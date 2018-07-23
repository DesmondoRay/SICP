;;; ambeval-require-element.scm
;;; page 288

(ambeval '(define (require p)
            (if (not p) (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (an-element-of items)
            (require (not (null? items)))
            (amb (car items) (an-element-of (cdr items))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

