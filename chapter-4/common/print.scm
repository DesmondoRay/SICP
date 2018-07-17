;;; print all results
;;; 接收多个参数，依次打印每个参数

(define (print . args)
  (cond ((null? args)
         (newline)
         (display "Print done!"))
        (else (newline)
              (display (car args))
              (apply print (cdr args)))))