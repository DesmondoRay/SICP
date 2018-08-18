(load "../common/make-table.scm")
(load "../common/put-get.scm")
(load "p73.scm")
(load "p73-b.scm")
(load "p73-c.scm")
(load "p73-tag-contents.scm")

(install-sum-package)
(install-product-package)
(install-exponentiation-package)

(newline)
(display (deriv '(** x 3) 'x))

;; output: (* 3 (** x 2))