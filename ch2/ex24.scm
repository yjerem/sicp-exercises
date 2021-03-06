(list 1 (list 2 (list 3 4)))
;=> (1 (2 (3 4)))
;
; Box-and-pointer structure:
;
;   [.|.]->[.|/]
;    |      |
;    1      [.|.]->[.|/]
;            |      |
;            2      [.|.]->[.|/]
;                    |      |
;                    3      4
;
; Tree structure:
;
;   (1 (2 (3 4)))
;       /\
;      /  \
;     1  (2 (3 4))
;           /\
;          /  \
;         2   (3 4)
;              /\
;             /  \
;            3    4
;

