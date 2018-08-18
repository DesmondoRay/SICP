;;; 84.scm
;;; 修改apply-generic，tag-contents.scm, raise-package, coercion

;; 原来的package
(load "general-arith.scm")
(load "complex-selector.scm")
(load "install-scheme-number-package.scm")
(load "install-complex-package.scm")
(load "install-polar-package.scm")
(load "install-rectangular-package.scm")
(load "install-rational-package.scm")
;;; 新增实数包 real-package
(load "install-real-package.scm")

(install-scheme-number-package)
(install-complex-package)
(install-polar-package)
(install-rectangular-package)
(install-rational-package)
(install-real-package)

(load "install-=zero?-package.scm")
(install-scheme-number-zero-package)
(install-complex-zero-package)
(install-rational-zero-package)
(install-real-zero-package)

(load "coercion.scm")
(load "install-raise-package.scm")


;;; 测试
(newline)
;;; 整数+有理数
(display (add 2 (make-rational 2 3)))
(newline)
;;; 整数+实数
(display (add 2 (make-real 3.5)))
(newline)
;;; 整数+复数
(display (add 2 (make-complex-from-real-imag 3 2)))
(newline)
;;; 有理数+实数
(display (add (make-rational 3 2) (make-real 3.2)))
(newline)
;;; 有理数+复数
(display (add (make-rational 3 2) (make-complex-from-real-imag 3 2)))
(newline)
;;; 实数+复数
(display (add (make-real 2.3) (make-complex-from-real-imag 3 2)))
(newline)
