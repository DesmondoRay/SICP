;;; parallel-execute.scm
;;; 在racket中才能正常工作

(define (parallel-execute . procs)
  (map thread-wait
       (map (lambda (proc) (thread proc))
            procs)))