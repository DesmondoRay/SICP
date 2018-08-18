;;; p80.scm
;;; 从这个练习可以看得出“数据导向的程序设计”的优点:
;;; 对于新增的操作几乎不需要修改之前的代码，只需要添加相应的package即可。
;;; 唯一需要修改的是: 在通用型运算符中(general-arith.scm)添加新增的操作。

;; 原来的package(同p79.scm)
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

;;; 新增的部分: 添加并安装新增的package
(load "install-scheme-number-zero-package.scm")
(load "install-complex-zero-package.scm")
(load "install-rational-zero-package.scm")

(install-scheme-number-zero-package)
(install-complex-zero-package)
(install-rational-zero-package)

;;; 测试
(newline)
(display (=zero? 0))
(newline)
(display (=zero? 3))

(newline)
(display (=zero? (make-complex-from-real-imag 0 0)))
(newline)
(display (=zero? (make-complex-from-real-imag 2 0)))

(newline)
(display (=zero? (make-rational 0 4)))
(newline)
(display (=zero? (make-rational 3 4)))
(newline)
(newline)

#| output: 
#t
#f
#t
#f
#t
#f
|#