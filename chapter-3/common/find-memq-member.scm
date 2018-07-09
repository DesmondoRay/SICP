(define a (list 3 1 4 2 5))
(find even? a)  ; > 4

(find-tail even? a)  ; > (4 2 5)

(find (lambda (x) (= x 2)) a) ; > 2

(find-tail (lambda (x) (= x 2)) a) ; > (2 5)


(memq 'a '(a b c))  ; > (a b c)
(memq 'b '(a b c))  ; > (b c)
(memq 'a '(b c d))  ; > #f
(memq (list 'a) '(b (a) c))    ; > #f
(member (list 'a) '(b (a) c))  ; > ((a) c)
(memq 101 '(100 101 102))      ; > (101 102)
(memv 101 '(100 101 102))      ; > (101 102)
