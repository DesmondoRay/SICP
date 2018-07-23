;;; exercise 4.49

(load "../common/parsing-natural-language.scm")

(ambeval 
 '(define (parse-word word-list)
    (require (not (null? *unparsed*)))
    (require (memq (car *unparsed*) (cdr word-list)))
    (let ((found-word (random-choice word-list)))
      (set! *unparsed* (cdr *unparsed*))
      (list (car word-list) found-word)))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

(ambeval
 '(define (random-choice lst)
    (define (iter index lst)
      (if (= index 0)
          (car lst)
          (iter (- index 1) (cdr lst))))
    (let ((len (- (length lst) 1)))
      (let ((index (random len)))
        (iter index (cdr lst)))))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

;; test
(driver-loop)
#|
(sentence 
 (noun-phrase (simple-noun-phrase (article a) 
                                  (noun professor)) 
              (prep-phrase (prep to) 
                           (simple-noun-phrase (article the) 
                                               (noun student)))) 
 (verb-phrase (verb eats) 
              (prep-phrase (prep by) 
                           (simple-noun-phrase (article the) 
                                               (noun student)))))

(sentence 
 (noun-phrase (simple-noun-phrase (article a) 
                                  (noun professor)) 
              (prep-phrase (prep in) 
                           (simple-noun-phrase (article a) 
                                               (noun professor)))) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep for) 
                           (simple-noun-phrase (article the) 
                                               (noun class)))))
|#