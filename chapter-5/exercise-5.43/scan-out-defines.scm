;;; exercise 4.16-b

(define (first-part proc) (car proc))

(define (rest-part proc) (cdr proc))

(define (scan-out-defines proc)
  (let ((let-list '())
        (set!-list '()))
    ; 将找到的内部定义转换并添加到let-list和set!-list
    (define (find-define proc)
      (if (null? proc)
          'done
          (let ((first (first-part proc)))
            (cond ((definition? first)
                   ; (display (definition-variable first))
                   (set! let-list
                         (cons (list (definition-variable first)
                                     "*unassigned*")
                               let-list))
                    (set! set!-list
                          (cons (list 'set!
                                      (definition-variable first)
                                      (definition-value first))
                                set!-list))
                   (find-define (rest-part proc)))
                  (else
                   (find-define (rest-part proc)))))))
    (find-define proc)
    (if (null? let-list)
        proc
        (list (append (list 'let let-list)
                set!-list
                (filter (lambda (x)  ; 删除内部定义
                          (not (definition? x)))
                        proc))))))