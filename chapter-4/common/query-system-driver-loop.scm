;;; 4.4.4.1 The Driver Loop and Instantiation
;;; page 325

(load "../common/query-system-evaluator.scm")
(load "../common/query-system-find-assertions.scm")
(load "../common/query-system-rules-unification.scm")
(load "../common/query-system-maintaining-datebase.scm")
(load "../common/query-system-stream-operations.scm")
(load "../common/query-system-syntax-procedures.scm")
(load "../common/query-system-frames-bindings.scm")

(define input-prompt ";;; Query input:")

(define output-prompt ";;; Query results:")

(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! (add-assertion-body q))
           (newline)
           (display "Assertion added to data base.")
           (query-driver-loop))
          (else
           (newline)
           (display output-prompt)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate q
                            frame
                            (lambda (v f)
                              (contract-question-mark v))))
             (qeval q (singleton-stream '()))))
           (query-driver-loop)))))

(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (copy (binding-value binding))
                 (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))


;; 4.1.4 page 265
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))
