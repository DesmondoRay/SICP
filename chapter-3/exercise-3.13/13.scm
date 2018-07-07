;;; 13.scm

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

;; test
(display (last-pair z))

;; 结果: 死循环