;;; 65.scm

(load "../exercise-3.55/55.scm")

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
			   (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream
  (partial-sums (ln-2 1)))

;; test
(load "../common/show-partial.scm")
(show-partial ln2-stream 100)

#| 输出：
1.
.5
.8333333333333333
.5833333333333333
.7833333333333332
.6166666666666666
....
.6983826391579893
.6879659724913226
.6982752508418381
.688071169209185
.698172179310195
.688172179310195
|#

; ln 2 = 0.69314718055995
; 收敛速度慢
