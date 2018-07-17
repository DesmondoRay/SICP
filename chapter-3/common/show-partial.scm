;;; show-partial.scm
;;; 打印流的前n个元素

(define (show-partial stream n)
  (define (show x)
    (display-line x)
    x)
  (define (display-line x)
    (newline)
    (display x))
  (define show-n (stream-ref (stream-map show stream) (- n 1)))
  show-n)