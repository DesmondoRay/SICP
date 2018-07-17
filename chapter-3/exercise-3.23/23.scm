;;; 23.scm
#| 
因为要求所有操作都应该在O(1)步骤内完成，若按照之前的方法定义，
rear-delete-deque!过程不能满足要求，所以修改列队结构如下:
 0, 说明
    首端项:(car (front-ptr deque))，尾端项: (car (rear-ptr deque)),
    首端数据项: (caar (front-ptr deque)), 即(front-deque deque);
 1, 列队的每个数据项从保存单独的数据改为保存一个序对，该序对的car部分
    保存数据，cdr部分保存上一个项的指针(首端项的cdr部分为空);
 2, 在首端添加项时，将目前首端项的cdr部分保存为指向新增项的指针;
 3, 在末尾添加项时，将新增项的cdr部分保存为指向目前末尾项的指针;
 4, 在执行rear-delete-deque!过程时，将rear-ptr设置为末尾项cdr部分
    指向的上一个项。
|#

;; 构造一个初始为空的表
(define (make-deque) (cons '() '()))

;; 选择和修改双端队列的前端和末端指针
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

;; 判断双端队列是否为空
(define (empty-deque? deque) (null? (front-ptr deque)))

;; 选取双端队列前端或末尾的数据项
(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (caar (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (caar (rear-ptr deque))))

;; 在双端队列前端或末尾插入一个线
(define (front-insert-deque! deque item)
  (let ((new-pair (cons (cons item '()) 
                        '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque)
          (else
           (set-cdr! new-pair (front-ptr deque))
           ; 将目前首端数据项的cdr部分保存为指向新增项的指针
           (set-cdr! (car (front-ptr deque)) new-pair)
           (set-front-ptr! deque new-pair)
           deque))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons (cons item '()) 
                        '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque)
          (else
           (set-cdr! (rear-ptr deque) new-pair)
           ; 将新增数据项的cdr部分保存为指向目前末尾数的指针
           (set-cdr! (car new-pair) (rear-ptr deque))
           (set-rear-ptr! deque new-pair)
           deque))))

;; 从双端队列的前端或末尾删除一个项
(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE-DEQUE! called with an empty deque"
                deque))
        (else
         (set-front-ptr! deque
                         (cdr (front-ptr deque)))
         (set-cdr! (car (front-ptr deque)) '())
         deque)))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE-DEQUE! called with an empty deque"
                deque))
         (else
          (set-rear-ptr! deque (cdr (car (rear-ptr deque))))
          (set-cdr! (rear-ptr deque) '())
          deque)))

;; 打印队列
(define (print-deque deque)
  (define (print-inner l)
    (if (null? l)
        (newline)
        (begin
         (display (caar l))
         (display " ")
         (print-inner (cdr l)))))
  (if (empty-deque? deque)
      (display '())
      (print-inner (front-ptr deque))))


;; test
(define d (make-deque))
(newline)
(display (empty-deque? d))
; 结果: #t

(newline)
(front-insert-deque! d 'a)
(print-deque d)
; 结果: a

(front-insert-deque! d 'b)
(print-deque d)
; 结果: b a

(front-insert-deque! d 'c)
(print-deque d)
; 结果: c b a

(rear-insert-deque! d 'd)
(print-deque d)
; 结果: c b a d

(rear-insert-deque! d 'e)
(print-deque d)
; 结果: c b a d e

(front-delete-deque! d)
(print-deque d)
; 结果: b a d e

(rear-delete-deque! d)
(print-deque d)
; 结果: b a d

(rear-delete-deque! d)
(print-deque d)
; 结果: b a

(display (front-deque d))
(newline)
; 结果: b

(display (rear-deque d))
(newline)
; 结果: a

