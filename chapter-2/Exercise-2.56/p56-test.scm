(load "p56.scm")
(load "../common/2-3-2-deriv.scm")

(display (deriv '(** x 0) 'x))
(newline)
(display (deriv '(** x 1) 'x))
(newline)
(display (deriv '(** x 2) 'x))
(newline)
(display (deriv '(** x 3) 'x))
(newline)

#| output:
0
1
(* 2 x)
(* 3 (** x 2))
|#