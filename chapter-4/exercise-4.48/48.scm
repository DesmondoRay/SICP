;;; exercise 4.48

(load "../common/parsing-natural-language.scm")

;; 形容词
(ambeval 
 '(define adjectives '(adjectives nice bright old clever cute))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 简单名词短语
(ambeval 
 '(define (parse-simple-noun-phrase)
    (amb (list 'simple-noun-phrase
               (parse-word articles)
               (parse-word nouns))
         (list 'simple-noun-phrase
               (parse-word articles)
               (parse-word adjectives)
               (parse-word nouns))))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

;; test
(driver-loop)
#|
;;; Amb-Eval input:
(parse '(the old professor lectures to the clever student with the cute cat))

;;; Starting a new problem 
;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (adjectives old) 
                     (noun professor)) 
 (verb-phrase 
  (verb-phrase (verb lectures) 
               (prep-phrase (prep to) 
                            (simple-noun-phrase (article the) 
                                                (adjectives clever) 
                                                (noun student)))) 
  (prep-phrase (prep with) 
               (simple-noun-phrase (article the) 
                                   (adjectives cute) 
                                   (noun cat)))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (adjectives old) 
                     (noun professor)) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep to) 
                           (noun-phrase 
                            (simple-noun-phrase (article the) 
                                                (adjectives clever) 
                                                (noun student)) 
                            (prep-phrase (prep with)
                                         (simple-noun-phrase (article the) 
                                                             (adjectives cute) 
                                                             (noun cat)))))))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(parse (quote (the old professor lectures to the clever student with the cute cat)))
|#