(load "../Exercise-2.68/p68.scm")
(load "../Exercise-2.69/p69.scm")

(define pairs (list (list 'A 2) 
                    (list 'NA 16) 
                    (list 'BOOM 1) 
                    (list 'SHA 3)
                    (list 'GET 2)
                    (list 'YIP 9)
                    (list 'JOB 2)
                    (list 'WAH 1)))

(define tree (generate-buffman-tree pairs))

(define msg1 '(GET A JOB))
(define msg2 '(SHA NA NA NA NA NA NA NA NA))
(define msg3 '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP))
(define msg4 '(SHA BOOM))

(define msg (append msg1 msg2 msg1 msg2 msg3 msg4))

(define code (encode msg tree))

(newline)
(display (length code))

;; output: 84