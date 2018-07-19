;;; exercise 4.25

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

(display (factorial 5))
;Aborting!: maximum recursion depth exceeded

;; 在正则序语言里能正常工作。