;;; exercise 4.74

;; a)
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (x)
                               (not (stream-null? x)))
                             stream)))

;; b)
; 查询系统的行为不会改变。