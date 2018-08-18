(load "../Exercise-2.50/p50.scm")

(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))
    
