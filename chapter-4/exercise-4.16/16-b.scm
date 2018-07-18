;;; exercise 4.16 b)
;; 注：需要写成"*unassigned*"，而不是'*unassigned*，后者会提示错误；
;;    为了让修改后的lookup-variable-defines正常工作，
;;    可能需要在全局环境下，将'*unassigned*约束到"*unassigned*"
;     ps：万万没想到会是这种情况，浪费好多时间

(load "../exercise-4.16/16-a.scm")

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


#|
;; test

(define a '(define var
             (define b 1)
             (define c 2)
             (+ b c)))

(define proc (cddr a))

(display (scan-out-defines proc))

; output:
(let ((c *unassigned*) 
      (b *unassigned*)) 
  (set! c 2) 
  (set! b 1) 
  (+ b c))
|#