;;; 97-b.scm
;;; 在../Exercise-93-97-common/install-scheme-number-package.scm
;;; 添加reduce-integers过程

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

;; exercise 2-97-b 
;; 修改install-rational-package.scm的make-rat过程
(load "install-rational-package.scm")
(install-rational-package)
(load "install-polynomial-package.scm")
(install-polynomial-package)


;; 测试分子分母为多项式的有理数
(define p1 (make-polynomial-sparse 'x '((1 1) (0 1))))
(define p2 (make-polynomial-sparse 'x '((3 1) (0 -1))))
(define p3 (make-polynomial-sparse 'x '((1 1))))
(define p4 (make-polynomial-sparse 'x '((2 1) (0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(newline)
(display (add rf1 rf2))
(newline)
; 测试结果，输出:
;   (rational (polynomial sparse x (3 -1) (2 -2) (1 -3) (0 -1)) 
;              polynomial sparse x (4 -1) (3 -1) (1 1) (0 1))
; 输出结果为最简形式


;; 测试分子分母为整数的有理数
(define r1 (make-rational 1 8))
(define r2 (make-rational 3 8))

(newline)
(display (add r1 r2))
(newline)
; 测试结果，输出:
;   (rational 1 . 2)
; 输出结果为最简形式
