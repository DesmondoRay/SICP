;;; 21.scm
(load "../common/queue.scm")

(define (print-queue queue)
  (define (print-inner l)
    (if (null? l)
        (newline)
        (begin
         (display (car l))
         (display " ")
         (print-inner (cdr l)))))
  (if (empty-queue? queue)
      (display '())
      (print-inner (front-ptr queue))))

;; test
(define q1 (make-queue))

(insert-queue! q1 'a)
(print-queue q1)

(insert-queue! q1 'b)
(print-queue q1)

(delete-queue! q1)
(print-queue q1)

(delete-queue! q1)
(print-queue q1)

#|
结果打印:
  a 
  a b 
  b 
  ()
|#