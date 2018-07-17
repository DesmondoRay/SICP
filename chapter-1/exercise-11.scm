;;; exercise 1.11

;; 递归
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

;; test 1
(newline)
(display (f 3))
(newline)
(display (f 4))
(newline)
(display (f 5))
(newline)
(display (f 7))
(newline)
; 结果:
;   4
;   11
;   25
;   142


;; 迭代
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

;; test 2
(newline)
(display (ff 3))
(newline)
(display (ff 4))
(newline)
(display (ff 5))
(newline)
(display (ff 7))
(newline)
; 结果:
;   4
;   11
;   25
;   142

