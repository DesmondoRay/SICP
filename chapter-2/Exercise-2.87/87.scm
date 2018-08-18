;;; 87.scm

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

;;; 测试
(define term-list1 (list (make-term 3 2) (make-term 2 2)))
(define term-list2 (list (make-term 3 3) (make-term 2 4)))
(define term-list3 (list (make-term 4 0) (make-term 3 0) (make-term 2 0)))

(newline)
(display (add (make-polynomial 'x term-list1)
              (make-polynomial 'x term-list2)))
(newline)
(display (mul (make-polynomial 'x term-list1)
              (make-polynomial 'x term-list2)))
(newline)
(display (=zero? (make-polynomial 'x term-list3)))
(newline)
(display (=zero? (make-polynomial 'x '())))
(newline)

#| output:
(polynomial x (3 5) (2 6))
(polynomial x (6 6) (5 14) (4 8))
#t
#t
|#