;;; exercise 5.38 d)

(load "38-b.scm")

(define (compile+ exp target linkage)
  (let ((operands (operands exp)))
    (if (> (length operands) 2)
        (compile (by-two-inputs '+ operands) target linkage)
        (let ((args (spread-arguments operands)))
          (end-with-linkage linkage
            (append-instruction-sequences (car args)
              (preserving '(arg1) (cadr args)
                (make-instruction-sequence 
                  '(arg1 arg2) (list target)
                  `((assign ,target (op +) (reg arg1) (reg arg2)))))))))))

(define (compile* exp target linkage)
  (let ((operands (operands exp)))
    (if (> (length operands) 2)
        (compile (by-two-inputs '* operands) target linkage)
        (let ((args (spread-arguments operands)))
          (end-with-linkage linkage
             (append-instruction-sequences (car args)
               (preserving '(arg1) (cadr args)
                 (make-instruction-sequence 
                   '(arg1 arg2) (list target)
                   `((assign ,target (op *) (reg arg1) (reg arg2)))))))))))

(define (by-two-inputs proc args)
  (if (null? (cdr args))
      (car args)
      (list proc 
            (car args)
            (by-two-inputs proc (cdr args)))))

;; test: by-two-inputs
; 1 ]=> (by-two-inputs '+ '(1 2 3 4))
; Value 13: (+ 1 (+ 2 (+ 3 4)))


;; test: compile+
(display
 (compile
  '(define f
     (+ 1 2 3 4))
  'val
  'next))
(newline) (newline)
#| output:
((env) (arg1 arg2 val) 
 ((assign arg1 (const 1)) 
  (save arg1) 
  (assign arg1 (const 2)) 
  (save arg1) 
  (assign arg1 (const 3)) 
  (assign arg2 (const 4)) 
  (assign arg2 (op +) (reg arg1) (reg arg2)) 
  (restore arg1) 
  (assign arg2 (op +) (reg arg1) (reg arg2)) 
  (restore arg1) 
  (assign val (op +) (reg arg1) (reg arg2)) 
  (perform (op define-variable!) (const f) (reg val) (reg env)) 
  (assign val (const ok))))
|#


;; test: compile*
(display
 (compile
  '(* a b c d)
  'val
  'next))
#| output: 
((env) (arg1 arg2 val) 
 ((assign arg1 (op lookup-variable-value) (const a) (reg env)) 
  (save arg1) 
  (assign arg1 (op lookup-variable-value) (const b) (reg env)) 
  (save arg1)
  (assign arg1 (op lookup-variable-value) (const c) (reg env)) 
  (assign arg2 (op lookup-variable-value) (const d) (reg env)) 
  (assign arg2 (op *) (reg arg1) (reg arg2)) 
  (restore arg1) 
  (assign arg2 (op *) (reg arg1) (reg arg2)) 
  (restore arg1) 
  (assign val (op *) (reg arg1) (reg arg2))))
|#