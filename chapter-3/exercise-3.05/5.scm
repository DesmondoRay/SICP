;;; 5.scm
;; 假定 x2 > x1, y2 > y1

(define (estimate-integral p x1 x2 y1 y2 trials)
  (* (* (- x2 x1) (- y2 y1))
     (monte-carlo trials (p x1 x2 y1 y2))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (* 1000 (- high low))))
    (+ low (/ (random range) 1000))))

(define (p-test x1 x2 y1 y2)
  (lambda ()
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (<= (+ (square (- x 5)) (square (- y 7))) 
          (square 3)))))

(define (estimate-pi)
  (/ (estimate-integral p-test 2.0 8 4 10 10000)
     9))

;; test
(newline)
(display (estimate-integral p-test 2.0 8 4 10 10000))
(newline)
(display (estimate-pi))

;; 结果输出:
;  第一次
;   28.152
;   3.1368
;  第二次
;   28.5264
;   3.1428

;; 注意: 
; 需要修改random-in-range，将范围乘以一个较大的系数再求随机数，
; 再将得到的随机数除以该系数，得到的随机数值较精确。
; 若是不乘以一个系数求随机数，则输出结果:
;   26.3016
;   2.912
; 得到的pi值始终为2.9左右。

