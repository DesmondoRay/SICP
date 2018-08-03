;;;; LOADS THE EXPLICIT-CONTROL EVALUATOR FROM SECTION 5.4 OF
;;;; STRUCTURE AND INTERPRETATION OF COMPUTER PROGRAMS, WITH
;;;; ALL THE SUPPORTING CODE IT NEEDS IN ORDER TO RUN.

;;;;This is like load-eceval.scm except that it loads the version
;;;; of eceval that interfaces with compiled code
;;;;It doesn't load the compiler itself -- loading the compiler is up to you.

;;;; **NB** The actual "load" calls are implementation dependent.

;reg machine simulator
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-regsim")

;; **NB** next file contains another "load"
;simulation of machine operations
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval-support")

;;**NB** eceval-compiler *must* be loaded after eceval-support,
;;  so that the version of user-print in eceval-compiler will override
;;  the version in eceval-support
;eceval itself
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval-compiler")
                    ;and interface to compiled code