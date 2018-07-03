;;; 95.scm

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
(install-scheme-number-package)
(install-complex-package)
(install-polar-package)
(install-rectangular-package)
(install-real-package)
(install-neg-package)
(install-poly-sparse-package)
(install-poly-dense-package)


;; exericse 2-93的install-rational-package.scm
(load "install-rational-package.scm")
(install-rational-package)
;; exercise 2-94修改后的install-polynomial-package.scm
(load "install-polynomial-package.scm")
(install-polynomial-package)

;; 测试
(define P1 (make-polynomial-sparse 'x '((2 1) (1 -2) (0 1))))
(define P2 (make-polynomial-sparse 'x '((2 11) (0 7))))
(define P3 (make-polynomial-sparse 'x '((1 13) (0 5))))
(define Q1 (mul p1 p2))
(define Q2 (mul p1 p3))
(newline)
(display (greatest-common-divisor Q1 Q2))
(newline)

;; 测试结果，输出:
;;   (polynomial sparse x (2 1458/169) (1 -2916/169) (0 1458/169))
;; 原因为: 在做多项式除法(div-terms)时最高次项的系数相除，得到的是分数
