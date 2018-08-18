;;; 86.scm
;;; 要实现复数的实部、虚部、模和幅角可以是常规数、有理数或其他类型，
;;; 只需将complex-package, polar-package, rectangular-package
;;; 中的运算符(如+，-，×，/)替换成通用运算符(如add, sub, mul, div)
;;; 同时，对于cos，sin，以及square和sqrt一类的运算也需要做一定的修改

;; 原来的package
(load "general-arith.scm")
(load "complex-selector.scm")
(load "install-scheme-number-package.scm")
(load "install-complex-package.scm")
(load "install-polar-package.scm")
(load "install-rectangular-package.scm")
(load "install-rational-package.scm")
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
(display (add (make-complex-from-real-imag (make-rational 3 2) 4)
              (make-complex-from-real-imag 2 (make-rational 3 4))))
(newline)
(display (magnitude (make-complex-from-real-imag (make-rational 3 2) 4)))
(newline)
(display (real-part (make-complex-from-mag-ang 4 (make-rational 3 2))))
(newline)