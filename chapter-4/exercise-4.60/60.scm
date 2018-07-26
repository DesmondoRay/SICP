;;; exercise 4.60

(assert!
 (rule (lives-near-all ?person-1 ?person-2)
       (and (address ?person-1 (?town . ?rest-1))
            (address ?person-2 (?town . ?rest-2))
            (not (same ?person-1 ?person-2))
            (lisp-value name>? ?person-1 ?person-2))))

;; 将姓名转换成字符串
(define (name->string person)
  (if (null? person)
      ""
      (string-append (symbol->string (car person))
                     (name->string (cdr person)))))
                     
(define (name>? p1 p2) 
  (string>? (name->sring p1) (name->string p2)))


#|
;; 注：只能用于查找所有居住较近的人，而不能用于指定某个人的情况。

;; string>? 和 string<? 用于比较字符串，如: 
(string<? "a" "b") ; --> #t
(string>? "abd" "abc") ; --> #t

;; (symbol->string symbol) 将symbol转换为字符串
(symbol->string 'name) ; --> "name"

;; (string-append str-a str-b) 将str-b添加到str-a后
(string-append "abc" "def") ; --> "abcdef"
|#
