;;; exercise 4.39

(define (multiple-dwelling)
  (let ((baker    (amb 1 2 3 4 5)) 
        (cooper   (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller   (amb 1 2 3 4 5))
        (smith    (amb 1 2 3 4 5)))
    (require (> miller cooper))
    (require (not (= cooper 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (not (= baker 5)))
    (require
     (distinct? (list baker cooper fletcher miller smith)))
    (list (list 'baker    baker)
          (list 'cooper   cooper)
          (list 'fletcher fletcher)
          (list 'miller   miller)
          (list 'smith    smith))))

#|
说明：
1、distinct?是最消耗时间的操作，所以放在最后；
2、(require (> miller cooper))能够将结果排除一半，而且只需要一次比较操作，所以放在最前；
3、紧接着(require (not (= cooper 1)))，避免后面的require对cooper = 1情况下不必要的计算；
4、(require (not (= (abs (- fletcher cooper)) 1)))排除60%的错误结果，但需要的操作较多；
5、(require (not (= xxx n)))类似的过程，排除20%的错误结果(fletcher除外，因为有两个)。
6、nonsence: 
(require (not (= (abs (- xxx xxx)) 1)))过程包含not，=，abs，- 以及require内部的not，共5个基本操作；
(require (not (= xxx n)))过程包含not，=，以及require内部的not，共3个基本操作；
(require (not (= (abs (- xxx xxx)) 1)))排除60%，“消耗”： 40% * 5；
(require (not (= xxx n)))排除20%： 80% * 3；
所以，(require (not (= (abs (- xxx xxx)) 1)))放在(require (not (= xxx n)))前面。
|#

;; test
(load "../common/amb-evaluator.scm") ; 由4.3.3实现

(driver-loop)

;; <test1: 原版>： 测试结果平均用时约为2.65秒
#|
;;; Amb-Eval input:
(define (test-once)
  (let ((start-time (runtime)))
    (newline)
    (display (multiple-dwelling))
    (newline)
    (display "runtime: ")
    (display (- (runtime) start-time))))

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 2.6500000000000004
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 2.6400000000000006
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 2.6599999999999984
;;; Amb-Eval value:
#!unspecific
|#

; ************************************************************
;; <test2: 改进版>： 测试结果平均用时约为1.22秒
#|
;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 1.2200000000000006
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 1.1999999999999993
;;; Amb-Eval value:
#!unspecific

;;; Amb-Eval input:
(test-once)

;;; Starting a new problem 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
runtime: 1.2300000000000004
;;; Amb-Eval value:
#!unspecific

#|

;; 注：两个测试舍弃了前几次结果，取后面3次结果，因为前两次结果不稳定。
