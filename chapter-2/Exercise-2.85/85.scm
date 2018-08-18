;;; 85.scm
;;; 修改general-arith.scm, 修改apply-generic.scm

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

;;; 新增drop-package
(load "install-drop-package.scm")

;;; 测试drop
(newline)
;(display (drop (make-complex-from-real-imag 3 0)))
(newline)
;(display (drop (make-complex-from-real-imag 3 2)))
(newline)
;(display (drop (make-real 3)))
(newline)
;(display (drop (make-real 3.5)))
(newline)
;(display (drop (make-rational 3 1)))
(newline)
;(display (drop (make-rational 3 2)))
(newline)
;;; 测试apply-generic
(display (add (make-complex-from-real-imag 3 2)
              (make-complex-from-real-imag 3 -2)))
(newline)
(display (add (make-real 3.3)
              (make-real 3.7)))
(newline)
(display (add (make-rational 3 2)
              (make-rational 1 2)))
(newline)

