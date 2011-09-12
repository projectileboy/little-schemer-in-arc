;;;; The Little Schemer - Chapter 2 - Do It, Do It Again, and Again, and Again...


; Let's define some synonyms so that our code doesn't look *quite* so different...
(= nil? no)
; #<procedure: no>
(= atom? atom)
; #<procedure: atom>
(= eq? is)
; #<procedure:...arc2-orig/ac.scm:582:10>


(def lat? (l)
    (or (nil? l) 					; IF l is nil, return true
        (and (atom? (car l)) 		; ELSE IF the first element of l is an atom
            (lat? (cdr l))))) 	;      AND the rest if l is a list of atoms, then l is a list of atoms
; #<procedure: lat?>
(lat? '(1 2 3 4 (1 2)))
; nil
(lat? '(1 2 3 4 5))
; t


(def member? (a l)
    (and l
        (or (eq? a (car l))
            (member? a (cdr l)))))
; #<procedure: member?>
(member? 2 '(4 5 6))
; nil
(member? 2 '(1 3 4 5 2))
; t
