;;; Driver loop
;;; page 302

(define input-prompt";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
           (newline) (display ";;; Starting a new problem ")
           (ambeval
            input
            the-global-environment
            ;; ambeval success
            (lambda (val next-alternative)
              (announce-output output-prompt)
              (user-print val)
              (internal-loop next-alternative))
            ;; ambeval failure
            (lambda ()
              (announce-output
               ";;; There are no more values of")
              (user-print input)
              (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline) (display ";;; There is no current problem")
     (driver-loop))))
