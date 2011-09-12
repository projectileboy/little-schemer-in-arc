;;;; The Little Schemer - Chapter 5 - *Oh My Gawd*: It's Full of Stars

(def rember* (a tree)
	(if (no tree) nil
		(is a (car tree)) (rember* a (cdr tree))
		(cons (if (atom (car tree)) (car tree) (rember* a (car tree))) 
			(rember* a (cdr tree)))))
		
; arc> (rember* 3 '(1 3 4 5 9 3 0 3))
; (1 4 5 9 0)
; arc> (rember* 3 '((3 7 6 3 3 9) 3 9 ((6 7) 3 (3 4 3)) 6 (5 6 3)))
; ((7 6 9) 9 ((6 7) (4)) 6 (5 6))


(def insertR* (new old tree)
	(if (no tree) nil		
		(is old (car tree)) 
			(cons (car tree) 
				(cons new 
					(insertR* new old (cdr tree))))		
		(cons (if (atom (car tree))
				(car tree) 
				(insertR* new old (car tree)))
			(insertR* new old (cdr tree)))))
			
; arc> (insertR* 99 3 '((3 7 6 3 3 9) 3 9 ((6 7) 3 (3 4 3)) 6 (5 6 3)))
; ((3 99 7 6 3 99 3 99 9) 3 99 9 ((6 7) 3 99 (3 99 4 3 99)) 6 (5 6 3 99))
			
		
(def occur* (a tree)
	(if (no tree) 0
		(is a (car tree)) (+ 1 (occur* a (cdr tree)))
		(atom (car tree)) (occur* a (cdr tree))
		(+ (occur* a (car tree)) (occur* a (cdr tree)))))

; arc> (occur* 3 '((3 7 6 3 3 9) 3 9 ((6 7) 3 (3 4 3)) 6 (5 6 3)))
; 8


(def subst* (new old tree)
	(if (no tree) nil		
		(is old (car tree)) 
			(cons new (subst* new old (cdr tree)))		
		(cons (if (atom (car tree))
				(car tree) 
				(subst* new old (car tree)))
			(subst* new old (cdr tree)))))

; arc> (subst* 99 3 '((3 7 6 3 3 9) 3 9 ((6 7) 3 (3 4 3)) 6 (5 6 3)))
; ((99 7 6 99 99 9) 99 9 ((6 7) 99 (99 4 99)) 6 (5 6 99))


(def insertL* (new old tree)
	(if (no tree) nil		
		(is old (car tree)) 
			(cons new 
				(cons (car tree) 
					(insertL* new old (cdr tree))))		
		(cons (if (atom (car tree))
				(car tree) 
				(insertL* new old (car tree)))
			(insertL* new old (cdr tree)))))
			
; arc> (insertL* 99 3 '((3 7 6 3 3 9) 3 9 ((6 7) 3 (3 4 3)) 6 (5 6 3)))
; ((99 3 7 6 99 3 99 3 9) 99 3 9 ((6 7) 99 3 (99 3 4 99 3)) 6 (5 6 99 3))

			
(def member* (a tree)
	(if (no tree) nil  
		(or (is a (car tree))
			(and (~atom (car tree)) (member* a (car tree)))
			(member* a (cdr tree)))))

; arc> (member* 76 '((()) (1 (2 4 5)) (((9 10) 8) 7) 76 (1 2)))
; t
; arc> (member* 76 '((()) (1 (2 4 5)) (((9 10) 8) 7) 99 (1 2)))
; nil
; arc> (member* 76 '(76))
; t
; arc> (member* 76 '())
; nil


(def leftmost (tree)
	(if (no tree) nil
		(atom (car tree)) (car tree)
		(aif (leftmost (car tree)) it (leftmost (cdr tree)))))

; arc> (leftmost '(1))
; 1
; arc> (leftmost '((()) (()) (((2 3)) 3) 4 5))
; 2


;(def eqtree?)


;(def equal?)


;(def rember)

		