(define (safe? k position)
  (iter (car position)
        (cdr position)
        1))

(define (iter row-of-new-queen rest-of-queens i)
  (if (null? rest-of-queens)
      true
      (let ((row-of-current-queen (car rest-of-queens)))
        (if (or (= row-of-new-queen row-of-current-queen)
                (= row-of-new-queen (+ row-of-current-queen i))
                (= row-of-new-queen (- row-of-current-queen i)))
            false
            (iter row-of-new-queen
                  (cdr rest-of-queens)
                  (+ 1 i))))))
