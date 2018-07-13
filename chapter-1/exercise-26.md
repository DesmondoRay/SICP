## 练习1.26

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (* (expmod base (/ exp 2) m)
					   (expmod base (/ exp 2) m))
					m))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))
```

使用(square proc)时，proc只需要进行一次计算，而使用显式的乘法则需要进行两次计算。