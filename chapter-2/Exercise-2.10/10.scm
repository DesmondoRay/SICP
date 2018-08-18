(define (make-interval a b) (cons a b))

(define (upper-bound a)
  (max (car a) (cdr a)))

(define (lower-bound a)
  (min (car a) (cdr a)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (or (= (lower-bound y) 0) (= (upper-bound y) 0))
      (error "divide by 0")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

;; test
(define a (make-interval 1 3))
(define b (make-interval 0 1))

#| output:
1 ]=> (div-interval a b)

;divide by 0
|#