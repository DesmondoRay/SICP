;;; p81.scm
;;; 修改apply-generic(p81-apply-generic.scm)

;; 原来的package
(load "general-arith.scm")
(load "complex-selector.scm")
(load "install-scheme-number-package.scm")
(load "install-complex-package.scm")
(load "install-polar-package.scm")
(load "install-rectangular-package.scm")
(load "install-rational-package.scm")

(install-scheme-number-package)
(install-complex-package)
(install-polar-package)
(install-rectangular-package)
(install-rational-package)

(load "install-=zero?-package.scm")
(install-scheme-number-zero-package)
(install-complex-zero-package)
(install-rational-zero-package)

;;; 新增p81-coercion.scm
(load "p81-coercion.scm")

;;; 测试
(display (add 1 2))
(newline)
