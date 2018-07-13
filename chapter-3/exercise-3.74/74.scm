;;; 74.scm

; (load "../exercise-3.50/50.scm")

(define zero-crossing
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))