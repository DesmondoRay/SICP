;;; 93.scm

(load "../Exercise-93-97-common/apply-generic.scm")
(load "../Exercise-93-97-common/general-arith.scm")
(load "../Exercise-93-97-common/complex-selector.scm")
(load "../Exercise-93-97-common/make-table.scm")
(load "../Exercise-93-97-common/put-get.scm")
(load "../Exercise-93-97-common/tag-contents.scm")
(load "../Exercise-93-97-common/coercion.scm")
(load "../Exercise-93-97-common/polynomial-selector.scm")

;; 之前的package
(load "../Exercise-93-97-common/install-scheme-number-package.scm")
(load "../Exercise-93-97-common/install-complex-package.scm")
(load "../Exercise-93-97-common/install-polar-package.scm")
(load "../Exercise-93-97-common/install-rectangular-package.scm")
(load "../Exercise-93-97-common/install-real-package.scm")
(load "../Exercise-93-97-common/install-=zero?-package.scm")
(load "../Exercise-93-97-common/install-raise-package.scm")
(load "../Exercise-93-97-common/install-neg-package.scm")
(load "../Exercise-93-97-common/install-poly-sparse-package.scm")
(load "../Exercise-93-97-common/install-poly-dense-package.scm")
(load "install-polynomial-package.scm")
(install-scheme-number-package)
(install-complex-package)
(install-polar-package)
(install-rectangular-package)
(install-real-package)
(install-neg-package)
(install-poly-sparse-package)
(install-poly-dense-package)
(install-polynomial-package)


;; exercise 2-93修改rational-package
;; 去掉简化过程，将+-*/改成add, sub, mul, div，修改equ?过程
;; install-=zero?-package可能也需要修改
(load "install-rational-package.scm")
(install-rational-package)

;; 测试
(define p1 (make-polynomial-sparse 'x '((2 1) (0 1))))
(define p2 (make-polynomial-sparse 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))
(newline)
(display rf)
(newline)
(display (add rf rf))
(newline)

;; 结果:
;	(rational (polynomial sparse x (3 1) (0 1)) polynomial sparse x (2 1) (0 1))
;	(rational (polynomial sparse x (5 2) (3 2) (2 2) (0 2)) 
;			   polynomial sparse x (4 1) (2 2) (0 1))

