;;; exercise 1.11

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(f 3)
(f 4)
(f 5)
(f 7)

(define (ff n)
  (f-iter 0 1 2 0 n))

(define (f-iter a b c i n)
  (if (= i n)
      a
      (f-iter b
              c
              (+ c (* 2 b) (* 3 a))
              (+ i 1)
              n)))

(ff 3)
(ff 4)
(ff 5)
(ff 7)