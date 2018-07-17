;;; 69.scm

(load "../common/interleave.scm")
(load "../common/integers.scm")
(load "../common/pairs.scm")

(define (triples s t u)
  (let ((pairs-tu (pairs t u)))
    (define (pair-s s pairs)
      (if (> (stream-car s) (car (stream-car pairs)))
          (pair-s s (stream-cdr pairs)) ; s > t直接跳过当前pairs的首个元素
          (cons-stream
           (cons (stream-car s) (stream-car pairs))
           (interleave
            (stream-map (lambda (x) (cons (stream-car s) x))
                        (stream-filter ; 过滤 s > t的pairs
                         (lambda (pair) (>= (car pair) (stream-car s)))
                         (stream-cdr pairs)))
            (pair-s (stream-cdr s) (stream-cdr pairs))))))
      (pair-s s pairs-tu)))

(define (pythagorean? a b c)
  (= (+ (square a) (square b))
     (square c)))

(define t (triples integers integers integers))

(define pythagorean-triples
  (stream-filter (lambda (x) (apply pythagorean? x))
                 t))

(stream-head pythagorean-triples 4)
; 结果: ((3 4 5) (6 8 10) (5 12 13) (9 12 15))
; 效率较低