;;; p79.scm

;;; 添加并安装package
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

;;; 测试
(newline)
(display (equ? 10 10))
(newline)
(display (equ? 10 11))
(newline)

(display (equ? (make-complex-from-real-imag 3 4)
			   (make-complex-from-real-imag 3 4)))
(newline)
(display (equ? (make-complex-from-real-imag 3 4)
			   (make-complex-from-real-imag 3 5)))
(newline)

(display (equ? (make-rational 5 7)
			   (make-rational 5 7)))
(newline)
(display (equ? (make-rational 0 7)
			   (make-rational 0 6)))
(newline)
(display (equ? (make-rational 5 7)
			   (make-rational 5 6)))
(newline)
(newline)

#| output:
#t
#f
#t
#f
#t
#t
#f
|#