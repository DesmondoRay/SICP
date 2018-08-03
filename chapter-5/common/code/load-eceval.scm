;;;; LOADS THE EXPLICIT-CONTROL EVALUATOR FROM SECTION 5.4 OF
;;;; STRUCTURE AND INTERPRETATION OF COMPUTER PROGRAMS, WITH
;;;; ALL THE SUPPORTING CODE IT NEEDS IN ORDER TO RUN.

;;;; **NB** The actual "load" calls are implementation dependent.

;reg machine simulator
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-regsim")

;; **NB** next file contains another "load"
;simulation of machine operations
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval-support")

;eceval itself
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval")