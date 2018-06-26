(load "set-tree.scm")
(load "set-sort.scm")
(load "p63.scm")
(load "p64.scm")

(define (union-tree tree1 tree2)
    (list->tree
        (union-set (tree->list-2 tree1)
                   (tree->list-2 tree2))))

(define ut (union-tree (list->tree '(1 2 3 4 5))
                       (list->tree '(1 3 5 7 9))))

(display (tree->list-2 ut))
(newline)

(define (intersection-tree tree1 tree2)
    (list->tree
        (intersection-set (tree->list-2 tree1)
                          (tree->list-2 tree2))))

(define it (intersection-tree (list->tree '(1 2 3 4 5))
                              (list->tree '(1 3 5 7 9))))

(display (tree->list-2 it))
(newline)