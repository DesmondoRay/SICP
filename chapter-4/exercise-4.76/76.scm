;;; exercise 4.76

(load "../common/query-system-driver-loop.scm")

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (merge-streams (qeval (first-conjunct conjuncts) frame-stream)
                     (conjoin (rest-conjuncts conjuncts) frame-stream))))

(define (merge-streams s1 s2) ; 合并stream
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else 
         (stream-flatmap (lambda (f1)
                           (stream-flatmap (lambda (f2)
                                             (merge-frame f1 f2))
                                           s2))
                         s1))))

(define (merge-frame f1 f2) ; 合并frame
  (if (null? f1)
      (singleton-stream f2)
      (let ((part1 (car f1)))
        (let ((part2 (assoc (car part1) f2)))
          (if part2                               ; 判断否f1中的变量是否出现在f2中
              (if (equal? (cdr part1) (cdr part2))  ; 判断相同变量的值是否“相等”
                  (merge-frame (cdr f1) f2)
                  the-empty-stream)
              (merge-frame (cdr f1) (cons part1 f2)))))))

(put 'and 'qeval conjoin)

;; test
(load "../common/4.4.1-a-sample-data-base.scm") ; 将Microshaft的人事信息放入数据库

(query-driver-loop)
#|
;;; Query input:
(and (job ?person (computer programmer))
     (address ?person ?where))

;;; Query results:
(and (job (fect cy d) (computer programmer)) (address (fect cy d) (cambridge (ames street) 3)))
(and (job (hacker alyssa p) (computer programmer)) (address (hacker alyssa p) (cambridge (mass ave) 78)))
|#