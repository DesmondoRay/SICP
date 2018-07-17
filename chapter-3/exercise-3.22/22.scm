;;; 22.scm

(define (make-queue-22)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-queue?) (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair))
              (else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)))))
    
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
             (set-front-ptr! (cdr front-ptr))
             )))
    
    (define (print-queue)
      (define (print-inner l)
        (if (null? l)
            (newline)
            (begin
             (display (car l))
             (display " ")
             (print-inner (cdr l)))))
      (if (empty-queue?)
          (display '())
          (print-inner front-ptr)))
    
    (define (dispatch m)
      (cond ((eq? m 'set-front-ptr!) set-front-ptr!)
            ((eq? m 'set-rear-ptr!) set-rear-ptr!)
            ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) (delete-queue!))
            ((eq? m 'print-queue) (print-queue))
            (else (error "Undefined operation -- CONS" m))))
    
    dispatch))

;; test
(define q1 (make-queue-22))

(newline)
((q1 'insert-queue!) 'a)
(q1 'print-queue)

((q1 'insert-queue!) 'b)
(q1 'print-queue)

(q1 'delete-queue!)
(q1 'print-queue)

(q1 'delete-queue!)
(q1 'print-queue)

#|
结果打印:
  a 
  a b 
  b 
  ()
|#

;; 注: 定义
; (define (insert-queue! queue item) 
;   ((queue 'insert-queue!) item))
; 即可使用原先的(insert-queue! q1 'a)过程，其他过程也可以使用类似的定义

