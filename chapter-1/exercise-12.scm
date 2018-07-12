;;; exercise 1.12

;; 计算第row行的第col个数的值
(define (count row col)
  (if (or (= col 1) (= row col))
      1
      (+ (count (- row 1) (- col 1))
         (count (- row 1) col))))

;; 打印第n行
(define (print-row n)
  (print-each n 1))

(define (print-each n i)
  (cond ((<= i n)
		 (display (count n i))
		 (display " ")
		 (print-each n (+ i 1)))
		(else
		 (newline))))

;; 打印帕斯卡三角形
(define (display-pascal n)
  (print-each-row n 1))

(define (print-each-row n i)
  (cond ((<= i n)
		 (print-row i)
		 (print-each-row n (+ i 1)))
		(display "done")))

;; test
(newline)
(display-pascal 6)
#| 输出:
1 
1 1 
1 2 1 
1 3 3 1 
1 4 6 4 1 
1 5 10 10 5 1
|#
