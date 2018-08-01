;;; exercise 5.8

(load "../common/5.2.1-the-machine-model.scm")

#| 使用正文里的 extract-labels 过程，得出 a = 3
(define exercise-8-machine
  (make-machine
   '(a)
   (list '())
   '(start
     (goto (label here))
     here
     (assign a (const 3))
     (goto (label there))
     here
     (assign a (const 4))
     (goto (label there))
     there)))

1 ]=> (start exercise-8-machine)

;Value: done

1 ]=> (get-register-contents exercise-8-machine 'a)

;Value: 3
|#

;; 修改 extract-labels
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels
       (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)  ; modify
                   (error "two labels with the same name -- EXTRACT-LABELS:"
                          next-inst)
                   (receive insts
                            (cons (make-label-entry next-inst
                                                    insts)
                                  labels)))
               (receive (cons (make-instruction next-inst)
                              insts)
                        labels)))))))

;; test 
(define exercise-8-machine
  (make-machine
   '(a)
   (list '())
   '(start
     (goto (label here))
     here
     (assign a (const 3))
     (goto (label there))
     here
     (assign a (const 4))
     (goto (label there))
     there)))

;; output:
;two labels with the same name -- EXTRACT-LABELS: here
