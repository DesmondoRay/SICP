;;; 88.scm

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

;; 新增的polynomial package
(load "install-polynomial-package.scm")
(install-polynomial-package)
;; 新增求负操作neg package
(load "install-neg-package.scm")
(install-neg-package)

;;; 测试
(define term-list1 (list (make-term 3 2) (make-term 2 2)))
(define term-list2 (list (make-term 3 3) (make-term 2 4)))

(newline)
(display (neg 3))
(newline)
(display (neg (make-rational 2 3)))
(newline)
(display (neg (make-real 3)))
(newline)
(display (neg (make-complex-from-real-imag 3 4)))
(newline)
(display (neg (make-polynomial 'x term-list2)))
(newline)
(display (sub (make-polynomial 'x term-list1)
              (make-polynomial 'x term-list2)))
(newline)

#| output:
-3
(rational -2 . 3)
(real . -3)
(complex rectangular -3 . -4)
(polynomial x (3 -3) (2 -4))
(polynomial polynomial x (3 -1) (2 -2))
|#