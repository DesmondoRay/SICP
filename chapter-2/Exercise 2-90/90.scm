;;; 90.scm
;;; 在计算时统一转换为dense，得到的结果也为dense

(load "../Exercise-87-91-common/apply-generic.scm")
(load "../Exercise-87-91-common/general-arith.scm")
(load "../Exercise-87-91-common/complex-selector.scm")
(load "../Exercise-87-91-common/make-table.scm")
(load "../Exercise-87-91-common/put-get.scm")
(load "../Exercise-87-91-common/tag-contents.scm")
(load "../Exercise-87-91-common/coercion.scm")

;; 之前的package
(load "../Exercise-87-91-common/install-scheme-number-package.scm")
(load "../Exercise-87-91-common/install-complex-package.scm")
(load "../Exercise-87-91-common/install-polar-package.scm")
(load "../Exercise-87-91-common/install-rectangular-package.scm")
(load "../Exercise-87-91-common/install-rational-package.scm")
(load "../Exercise-87-91-common/install-real-package.scm")
(load "../Exercise-87-91-common/install-=zero?-package.scm")
(load "../Exercise-87-91-common/install-raise-package.scm")
(install-scheme-number-package)
(install-complex-package)
(install-polar-package)
(install-rectangular-package)
(install-rational-package)
(install-real-package)

;; 新增的polynomial-selector.scm
(load "polynomial-selector.scm")
;; 新增求负操作neg package
(load "install-neg-package.scm")
(install-neg-package)
;; 新增的install-poly-sparse-package
(load "install-poly-sparse-package.scm")
(install-poly-sparse-package)
;; 新增的install-poly-dense-package
(load "install-poly-dense-package.scm")
(install-poly-dense-package)
;; 新增的polynomial package
(load "install-polynomial-package.scm")
(install-polynomial-package)


;;; 测试
(define term-list1 (list (make-term 3 2) (make-term 2 2)))
(define coeff-list1 (make-coefflist 1 2 0 3))
(define p1 (make-polynomial-sparse 'x term-list1))
(define p2 (make-polynomial-dense 'x coeff-list1))

(newline)
(display p1)
(newline)
(display p2)
(newline)
(display (add p1 p2))
(newline)
(display (sub p1 p2))
(newline)
(display (mul p1 p2))
(newline)
(display (neg p2))
(newline)

