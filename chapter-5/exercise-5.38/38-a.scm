;;; exercise 5.38

(define (spread-arguments argl)
  (let ((operand-code1 (compile (car argl) 'arg1 'next))
        (operand-code2 (compile (cadr argl) 'arg2 'next)))
    (list operand-code1 operand-code2)))