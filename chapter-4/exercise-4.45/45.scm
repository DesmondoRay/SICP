;;; exercise 4.45

(load "../common/parsing-natural-language.scm")

(driver-loop)

;;; Amb-Eval input:
(parse '(the professor lectures to the student in the class with the cat))

;;; Starting a new problem 
;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase 
  (verb-phrase 
   (verb-phrase (verb lectures) 
                (prep-phrase (prep to) 
                             (simple-noun-phrase (article the) 
                                                 (noun student)))) 
   (prep-phrase (prep in) 
                (simple-noun-phrase (article the) 
                                    (noun class)))) 
  (prep-phrase (prep with) 
               (simple-noun-phrase (article the) 
                                   (noun cat)))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase 
  (verb-phrase (verb lectures) 
               (prep-phrase (prep to) 
                            (simple-noun-phrase (article the) 
                                                (noun student)))) 
  (prep-phrase (prep in) 
               (noun-phrase (simple-noun-phrase (article the) 
                                                (noun class)) 
                            (prep-phrase (prep with) 
                                         (simple-noun-phrase (article the) 
                                                             (noun cat)))))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase
  (verb-phrase (verb lectures) 
               (prep-phrase (prep to) 
                            (noun-phrase 
                             (simple-noun-phrase (article the) 
                                                 (noun student)) 
                             (prep-phrase (prep in) 
                                          (simple-noun-phrase (article the) 
                                                              (noun class)))))) 
  (prep-phrase (prep with) 
               (simple-noun-phrase (article the) 
                                   (noun cat)))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep to) 
                           (noun-phrase 
                            (noun-phrase 
                             (simple-noun-phrase (article the) 
                                                 (noun student)) 
                             (prep-phrase (prep in) 
                                          (simple-noun-phrase (article the) 
                                                              (noun class)))) 
                            (prep-phrase (prep with) 
                                         (simple-noun-phrase (article the) 
                                                             (noun cat)))))))

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(sentence 
 (simple-noun-phrase (article the) 
                     (noun professor)) 
 (verb-phrase (verb lectures) 
              (prep-phrase (prep to) 
                           (noun-phrase 
                            (simple-noun-phrase (article the) 
                                                (noun student)) 
                            (prep-phrase (prep in) 
                                         (noun-phrase 
                                          (simple-noun-phrase (article the)
                                                              (noun class)) 
                                          (prep-phrase (prep with) 
                                                       (simple-noun-phrase (article the) 
                                                                           (noun cat)))))))))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(parse (quote (the professor lectures to the student in the class with the cat)))