;;; install-poly-sparse-package.scm
;;; 稀疏型多项式安装包

(define (install-poly-sparse-package)
  ;;internal procedures
  (define (make-poly-sparse variable term-list)
    (cons variable term-list))
  
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  
   ;; interface to the rest of the system
  (define (tag x) (attach-tag 'sparse x))
  
  (put 'variable '(sparse) variable)
  
  (put 'term-list '(sparse) term-list)
  
  (put 'make-poly-sparse 'sparse
       (lambda (var terms) (tag (make-poly-sparse var terms))))
  
  'done)

(define (make-poly-sparse var terms)
    ((get 'make-poly-sparse 'sparse) var terms))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))