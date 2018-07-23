;;; Parsing natural language

(load "../common/amb-evaluator.scm")

;; 名词
(ambeval 
 '(define nouns '(noun student professor cat class))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 动词
(ambeval 
 '(define verbs '(verb studies lectures eats sleeps))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 冠词
(ambeval 
 '(define articles '(article the a))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

(ambeval 
 '(define (parse-word word-list)
    (require (not (null? *unparsed*)))
    (require (memq (car *unparsed*) (cdr word-list)))
    (let ((found-word (car *unparsed*)))
      (set! *unparsed* (cdr *unparsed*))
      (list (car word-list) found-word)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

(ambeval 
 '(define *unparsed* '())
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

(ambeval 
 '(define (parse input)
    (set! *unparsed* input)
    (let ((sent (parse-sentence)))
      (require (null? *unparsed*)) sent))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 介词
(ambeval 
 '(define prepositions '(prep for to in by with))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 介词短语：一个介词后跟一个名词
(ambeval 
 '(define (parse-prepositional-phrase)
    (list 'prep-phrase
          (parse-word prepositions)
          (parse-noun-phrase)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 分析句子：名词短语后跟一个动词短语
(ambeval 
 '(define (parse-sentence)
    (list 'sentence (parse-noun-phrase) (parse-verb-phrase)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 动词短语：可以是一个动词，也可以是一个动词短语加上一个介词短语
(ambeval 
 '(define (parse-verb-phrase)
    (define (maybe-extend verb-phrase)
      (amb verb-phrase
           (maybe-extend
            (list 'verb-phrase
                  verb-phrase
                  (parse-prepositional-phrase)))))
    (maybe-extend (parse-word verbs)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 简单名词短语：一个简短名词短语，或是一个名词短语后跟一个介词短语
(ambeval 
 '(define (parse-simple-noun-phrase)
    (list 'simple-noun-phrase
          (parse-word articles)
          (parse-word nouns)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; 名词短语
(ambeval 
 '(define (parse-noun-phrase)
    (define (maybe-extend noun-phrase)
      (amb noun-phrase
           (maybe-extend
            (list 'noun-phrase
                  noun-phrase
                  (parse-prepositional-phrase)))))
    (maybe-extend (parse-simple-noun-phrase)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

; (driver-loop)