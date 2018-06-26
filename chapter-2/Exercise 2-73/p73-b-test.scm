(load "p73.scm")
(load "p73-b.scm")
(load "p73-tag-contents.scm")

(install-sum-package)
(newline)
(display (deriv '(+ x 3) 'x))
(newline)

(install-product-package)
(display (deriv '(* x y) 'x))
(newline)
(newline)