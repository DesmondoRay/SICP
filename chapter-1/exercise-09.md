# 练习 1.9

## 1 递归
```scheme
(define (+ a b)
  (if (= a 0)
	  b
	  (inc (+ (dec a) b))))
```
代换模型:
``` scheme
(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
```

## 2 迭代
```scheme
(define (+ a b)
  (if (= a 0)
	  b
	  (+ (dec a ) (inc b))))
```
代换模型:
``` scheme
(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
0
```