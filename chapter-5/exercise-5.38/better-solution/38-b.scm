;;; exercise 5.38 b)

;;it return list like '((reg arg1) (reg arg2) ... )
;;for each reg in arg-regs passed
(define (make-arg-regs-list arg-regs)
  (map (lambda(reg)
         (list 'reg reg))
       arg-regs))

(define (compile-open-code operation operands-list target linkage)
  (let ((operands-length (length operands-list)))
    (if (> operands-length total-arg-regs)
        (error "Open code primitive operands are more than the available arg regs.")
        (let ((arg-regs (take all-arg-regs operands-length)))
          ;;recall that end-with-linkage preserves continue register
          (end-with-linkage
           linkage
           (append-instruction-sequences
            (spread-arguments operands-list)
            (make-instruction-sequence
             arg-regs
             `(,target)
             `((assign ,target
                       (op ,operation)
                       . ;;notice the dot
                       ,(make-arg-regs-list arg-regs))))))))))

(define (same? exp) (tagged-list? exp '=))
(define (mul? exp) (tagged-list? exp '*))
(define (sub? exp) (tagged-list? exp '-))
(define (add? exp) (tagged-list? exp '+))

(define (compile-same exp target linkage)
  (compile-open-code '= (operands exp) target linkage))

(define (compile-sub exp target linkage)
  (compile-open-code '- (operands exp) target linkage))

;;below to procedures contains the change correspoding to part(d)
(define (compile-add exp target linkage)
  (split-and-compile '+ (operands exp) target linkage))

(define (compile-mul exp target linkage)
  (split-and-compile '* (operands exp) target linkage))

;;Additions in compile procedure

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((same? exp) (compile-same exp target linkage))
        ((add? exp) (compile-add exp target linkage))
        ((sub? exp) (compile-sub exp target linkage))
        ((mul? exp) (compile-mul exp target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))
