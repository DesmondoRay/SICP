(define (attach-tag type-tag contents)
  (if (and (number? contents) (not (equal? type-tag 'real)))
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum)
         (car datum))
        (else
         (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum)
         (cdr datum))
        (else 
         (error "Bad tagged datum -- CONTENTS" datum))))