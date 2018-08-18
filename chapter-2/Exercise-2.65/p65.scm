(load "../common/set-tree.scm")
(load "../common/set-sort.scm")
(load "../Exercise-2.62/p62.scm")
(load "../Exercise-2.63/p63.scm")
(load "../Exercise-2.64/p64.scm")

(define (union-tree tree1 tree2)
    (list->tree
        (union-set (tree->list-2 tree1)
                   (tree->list-2 tree2))))

(define (intersection-tree tree1 tree2)
    (list->tree
        (intersection-set (tree->list-2 tree1)
                          (tree->list-2 tree2))))


;; test
(define ut (union-tree (list->tree '(1 2 3 4 5))
                       (list->tree '(1 3 5 7 9))))

(display (tree->list-2 ut))
(newline)

;; output: (1 2 3 4 5 7 9)

(define it (intersection-tree (list->tree '(1 2 3 4 5))
                              (list->tree '(1 3 5 7 9))))

(display (tree->list-2 it))
(newline)

;; output: (1 3 5)