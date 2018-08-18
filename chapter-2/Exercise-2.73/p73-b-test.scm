(load "p73.scm")
(load "p73-b.scm")
(load "p73-tag-contents.scm")
(load "../common/make-table.scm")
(load "../common/put-get.scm")

(install-sum-package)
(newline)
(display (deriv '(+ x 3) 'x))
(newline)
;; output: 1

(install-product-package)
(display (deriv '(* x y) 'x))
(newline)
(newline)
;; output: y