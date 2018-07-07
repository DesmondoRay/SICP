;;; 8.scm

(define (internal)
  (let ((val 1))
	(lambda (x)
	   (set! val (+ val x -1))
	   val)))

(define f 
  (internal))
(define g
  (internal))
;; test
(newline)
(display (+ (f 0) (f 1)))
(newline)
(display (+ (g 1) (g 0)))
(newline)

;; 结果输出:
;	1
;	0
; 表明(+ (f 0) (f 1))的求值为对实际参数采用从右到左的顺序


;; 可能更好的答案: 但是只能测试第一次
; f在第一次被调用的时候，返回调用它的参数first-value，
; 然后将f设置(重新定义)为一个无论接受什么参数都只返回0的过程，
; 因此最终求值结果就由第一次调用f的参数决定了。
(define f-better
    (lambda (first-value)
        (set! f-better (lambda (second-value) 0))
        first-value))

(newline)
(display (+ (f-better 0) (f-better 1)))
(newline)
(display (+ (f-better 0) (f-better 1)))
(newline)
(display (+ (f-better 1) (f-better 0)))

; 结果:
; 	1
;	0
;	0

