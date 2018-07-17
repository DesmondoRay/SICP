;;; 队列

;; 构造一个初始为空的表
(define (make-queue) (cons '() '()))

;; 选择和修改队列的前端和末端指针
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

;; 判断队列是否为空
(define (empty-queue? queue) (null? (front-ptr queue)))

;; 选取队列前端的数据项
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

;; 在队列末尾插入一个数据线
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

;; 从队列的前端删除一个数据项
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue"
                queue))
        (else
         (set-front-ptr! queue
                         (cdr (front-ptr queue)))
         queue)))