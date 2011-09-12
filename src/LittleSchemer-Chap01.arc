;;;; The Little Schemer - Chapter 1 - Toys

(= *abc$ nil)
; nil
(atom *abc$)
; t

(= list? ~atom)
; #<procedure: list?>
(= atom? atom)
; #<procedure: atom>

(list? '(1 2 3))
; t
(atom? 1)
; t

(car '(1 2 3))
; 1
(cdr '(1 2 3))
; (2 3)

; Note - Arc lets us take the cdr of an empty list! Scheme would blow up on these...
(cdr '())
; nil
(cdr nil)
; nil

; But of course, we still can't take the cdr of an atom...
(cdr 1)
; Error: "Can't take the cdr of 1"

(= a 'peanut)
; peanut
(= l '(butter and jelly))
; (butter and jelly)

(cons a l)
; (peanut butter and jelly)


; Note - Arc lets us call 'no' on atoms! Scheme only lets you call 'null?' on lists...
(= nil? no)
; #<procedure: no>
(nil? a)
; nil
(nil? l)
; nil
(nil? '())
; t
(nil? nil)
; t

(= eq? is)
; #<procedure:...arc2-orig/ac.scm:582:10>

(= x 12)
; 12
(= y 12)
; 12

(eq? x y)
; t
(eq? x '(12))
; nil
(eq? '(12) '(12))
; nil
(iso '(12) '(12))
; t
