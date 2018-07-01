;;; 83.scm
;;; 修改general-arith.scm, coercion.scm

;; 原来的package
(load "83-general-arith.scm")
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

(load "83-coercion.scm")

;;; 新增(install-raise-package.scm)
(load "83-install-raise-package.scm")

;;; 测试
(newline)
(display (raise 2))
(newline)
