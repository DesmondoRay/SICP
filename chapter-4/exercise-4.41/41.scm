;;; exercise 4.41

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define baker '(1 2 3 4))
(define cooper '(2 3 4 5))
(define fletcher '(2 3 4))
(define miller '(1 2 3 4 5))
(define smith '(1 2 3 4 5))

(define (flatmap op lst)
  (if (null? lst)
      '()
      (let ((result (op (car lst))))
        ((if (pair? result) append cons)
         result
         (flatmap op (cdr lst))))))

(define (permutations lst)
  (if (null? lst)
      '(())
      (flatmap (lambda (x)
                 (map (lambda (y) (cons x y))
                      (permutations (cdr lst))))
               (car lst))))

(define (restrictions lst)
  (apply
   (lambda (baker cooper fletcher miller smith)
     (and (> miller cooper)
          (not (= (abs (- smith fletcher)) 1))
          (not (= (abs (- fletcher cooper)) 1))
          (distinct? (list baker cooper fletcher miller smith))))
   lst))
 
(define dwelling
  (filter restrictions 
          (permutations (list baker cooper fletcher miller smith))))

(define multiple-dwelling
  (apply (lambda (baker cooper fletcher miller smith)
           (list (list 'baker baker)
                 (list 'cooper cooper)
                 (list 'fletcher fletcher)
                 (list 'miller miller)
                 (list 'smith smith)))
         (car dwelling)))


;; test
;1 ]=> multiple-dwelling

;Value 13: ((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
