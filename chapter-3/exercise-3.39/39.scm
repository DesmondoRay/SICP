;;; 39.scm

(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s lambda () (* x x)))))
                  (s (lambda () (set! x (+ x 1)))))

; 可能出现的值有: 101, 121, 100