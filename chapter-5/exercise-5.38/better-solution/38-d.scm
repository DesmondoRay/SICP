;;; exercise 5.38 d)

(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-compiler.scm")
(load "/home/desmondo/Documents/git/SICP/chapter-5/exercise-5.38/better-solution/38-a.scm")
(load "/home/desmondo/Documents/git/SICP/chapter-5/exercise-5.38/better-solution/38-b.scm")

(define (split items n)
  (cond ((= n 0) (cons '() items))
        ((null? items) (cons '() '()))
        (else (let ((n-1-split (split (cdr items)
                                      (- n 1))))
                (cons (cons (car items)
                            (car n-1-split))
                      (cdr n-1-split))))))

(define (split-and-compile operator operands target linkage)
  (let ((splitted (split operands total-arg-regs)))
    (let ((first-part (car splitted))
          (rem-part (cdr splitted)))
      (if (null? rem-part)
          (compile-open-code operator first-part target linkage)
          (let ((new-operand-1 (cons operator first-part))
                (new-operand-2 (if (null? (cdr rem-part))
                                   (car rem-part)
                                   (cons operator rem-part))))
            (compile-open-code operator
                               (list new-operand-1 new-operand-2)
                               target
                               linkage))))))