;;; 91.scm
;;; 在install-polynomial-package.scm添加div-poly运算

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

;; 需要注意加载和安装包的顺序
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

;; 测试
(define termlist-1 (list (make-term 5 1) (make-term 0 -1)))
(define termlist-2 (list (make-term 2 1) (make-term 0 -1)))
(define poly-1 (make-polynomial-sparse 'x termlist-1))
(define poly-2 (make-polynomial-sparse 'x termlist-2))

(newline)
(display (div poly-1 poly-2))
(newline)

;; output: ((polynomial sparse x (3 1) (1 1)) (polynomial sparse x (1 1) (0 -1)))