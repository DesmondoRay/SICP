;;; exercise 1.16

(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b n a)
  (cond ((= n 0)
         a)
        ((even? n)
         (expt-iter (* b b)
                    (/ n 2)
                    a))
        ((odd? n)
         (expt-iter b
                    (- n 1)
                    (* b a)))))

;; test
(newline)
(display (expt 2 10))
(newline)
(display (expt 2 28))
; 结果:
;   1024
;   268435456

