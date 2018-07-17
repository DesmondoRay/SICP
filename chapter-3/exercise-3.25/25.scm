;;; 25.scm

(define (make-table)
  (let ((local-table (list '*table*)))
    ; 定义内部lookup，需要两个参数: 关键码列表和一个表格
    (define (lookup-internal key-list subtable)
      (let ((record (assoc (car key-list) (cdr subtable))))
        (if record
            (let ((rest-keys (cdr key-list)))
              (if (null? rest-keys)
                  (cdr record)
                  (lookup-internal rest-keys record)))
            false)))
    ; 定义外部lookup，只需要关键码列表一个参数
    (define (lookup key-list)
      (lookup-internal key-list local-table))
    
    ; 定义内部insert!，三个参数: 关键码列表，值，表格
    (define (insert!-internal key-list value subtable)
      (let ((record (assoc (car key-list) (cdr subtable)))
            (first-key (car key-list))
            (rest-keys (cdr key-list)))
        (if record
            (if (null? rest-keys)
                (set-cdr! record value)
                (insert!-internal rest-keys value record))
            (if (null? rest-keys)
                (set-cdr! subtable (cons (cons first-key value)
                                         (cdr subtable)))
                (begin
                 (set-cdr! subtable (cons (list first-key)
                                          (cdr subtable)))
                 (insert!-internal rest-keys value (cadr subtable)))))))
    ; 定义外部insert!，两个参数: 关键码列表，值
    (define (insert! key-list value)
      (insert!-internal key-list value local-table))
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'display) (display local-table))
            (else (error "Unknown opeartion -- TABLE" m))))
  dispatch))


;; test
(define t (make-table))
(define get (t 'lookup-proc))
(define put (t 'insert-proc!))

(put '(math arith add) 1)
(newline)
(t 'display)
; 打印: (*table* (math (arith (add . 1))))

(put '(math arith sub) 2)
(newline)
(t 'display)
; 打印: (*table* (math (arith (sub . 2) (add . 1))))

(newline)
(display (get '(math arith add)))
; 输出: 1
(newline)
(display (get '(math arith sub)))
; 输出: 2

; 更新已有的值
(put '(math arith add) 5)
(newline)
(display (get '(math arith add)))
; 输出: 5


(put '(a b c d e) 3)
(put '(e f g h i) 4)
(newline)
(display (get '(a b c d e)))
; 输出: 3
(newline)
(display (get '(e f g h i)))
; 输出: 4

(newline)
(display (get '(a c b)))
; 输出: #f

