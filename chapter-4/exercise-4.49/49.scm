;;; exercise 4.49

(load "../common/parsing-natural-language.scm")

(ambeval 
 '(define (parse-word word-list) 
    (require (not (null? *unparsed*))) 
    (require (memq (car *unparsed*) (cdr word-list))) 
    (let ((found-word (car *unparsed*))) 
      (set! *unparsed* (cdr *unparsed*)) 
      (list-amb (cdr word-list))))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

(ambeval
 '(define (list-amb li) 
    (if (null? li) 
        (amb) 
        (amb (car li) (list-amb (cdr li)))))
 the-global-environment
 (lambda (value fail) value)
 (lambda () 'failed))

;; test
(driver-loop)
#|
(sentence 
;;; Amb-Eval input:
(parse '(the student with the cat sleeps in the class))

;;; Starting a new problem 
;;; Amb-Eval value:
(sentence 
(noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase the student))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase the professor))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase the cat))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase the class))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase a student))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase a professor))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase a cat))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase a class))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase to (simple-noun-phrase the student))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase to (simple-noun-phrase the professor))))

|#