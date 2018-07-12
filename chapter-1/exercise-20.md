## 练习1.20

### 正则序代换
```scheme
(gcd 206 40)
(gcd 40 (remainder 206 40))
; r1 = (remainder 206 40) = 6 不等于0
(gcd r1 (remainder 40 r1))
; r2 = (remainder 40 r1) = 4 不等于0
(gcd r2 (remainder r1 r2))
; r3 = (remainder r1 r2) = 2 不等于0
(gcd r3 (remainder r2 r3))
; r4 = (remainder r2 r3) = 0
; 使用remainder次数： r1 = 1, r2 = 2, r3 = 3, r4 = 5;
; 代换：
(gcd 206 40)
(gcd 40 r1) ;计算次数: 1
(gcd r1 r2) ;计算次数: 2
(gcd r2 r3) ;计算次数: 3
(gcd r3 r4) ;计算次数: 5, 计算得 r4 = 0
r3          ;计算次数: 3
```
总次数: 14

### 应用序
```scheme
(gcd 206 40)
(gcd 40 (remainder 206 40)) 1
(gcd 40 6)
(gcd 6 (remainder 40 6)) 2
(gcd 6 4)
(gcd 4 (remainder 6 4)) 3
(gcd 4 2)
(gcd 4 (remainder 4 2)) 4
(gcd 4 0)
4
```
总次数: 4

