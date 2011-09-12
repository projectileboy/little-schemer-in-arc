;;;; The Little Schemer - Chapter 3 - Cons the Magnificent

; This time we'll dispense with the synonyms, and just work with vanilla Arc code...


(def rember (a lat)
	(if (no lat) nil
		(is a (car lat)) (cdr lat)
		(cons (car lat) (rember a (cdr lat)))))
; #<procedure: rember>
(rember 3 '(2 4 5 6 3 7 8 9))
; (2 4 5 6 7 8 9)		
(rember 5 '(5 1 3 4 5 7 5 9 5 10 5 12 5))
; (1 3 4 5 7 5 9 5 10 5 12 5)


(def firsts (ll)
	(if (no ll) nil
		(cons 
			(if (atom (car ll)) (car ll) 
				(car (car ll)))
			(firsts (cdr ll)))))		
; #<procedure: firsts>
(firsts '((1 2 3 4) (9 8 7 6 5) 5 (1 2 3) 4 6 (0 9 8)))
; (1 9 5 1 4 6 0)			


(def insertR (new old lat)
	(if (no lat) nil
		(is old (car lat)) 
			(cons (car lat) 
				(cons new (cdr lat)))
		(cons (car lat) 
			(insertR new old (cdr lat)))))
; #<procedure: insertR>
(insertR 99 8 '(1 3 4 5 6 8 12 13))
; (1 3 4 5 6 8 99 12 13)


(def insertL (new old lat)
	(if (no lat) nil
		(is old (car lat))
			(cons new lat)
		(cons (car lat)
			(insertL new old (cdr lat)))))
; #<procedure: insertL>
(insertL 99 8 '(1 3 4 5 6 8 12 13))
; (1 3 4 5 6 99 8 12 13)



(def subst (new old lat)
	(if (no lat) nil
		(is old (car lat))
			(cons new (cdr lat))
		(cons (car lat)
			(subst new old (cdr lat)))))
; #<procedure: subst>
(subst 99 8 '(1 3 4 5 6 8 12 13))
; (1 3 4 5 6 99 12 13)


(def subst2 (new old1 old2 lat)
	(if (no lat) nil
		(or (is old1 (car lat)) (is old2 (car lat)))
			(cons new (cdr lat))
		(cons (car lat)
			(subst2 new old1 old2 (cdr lat)))))
; #<procedure: subst2>
(subst2 99 5 8 '(1 3 4 5 6 8 12 13))
; (1 3 4 99 6 8 12 13)
(subst2 99 5 4 '(1 3 4 5 6 8 12 13))
; (1 3 99 5 6 8 12 13)
						
			
(def multirember (a lat)
	(if (no lat) nil
		(is a (car lat)) (multirember a (cdr lat))
		(cons (car lat) (multirember a (cdr lat)))))
; #<procedure: multirember>
(multirember 5 '(5 1 3 4 5 7 5 9 5 10 5 12 5))
; (1 3 4 7 9 10 12)


(def multiinsertR (new old lat)
	(if (no lat) nil
		(is old (car lat)) 
			(cons (car lat) (cons new (multiinsertR new old (cdr lat))))
		(cons (car lat) (multiinsertR new old (cdr lat)))))
; #<procedure: multiinsertR>
(multiinsertR 99 5 '(5 1 3 4 5 75 9 5 10 5 12 5))
; (5 99 1 3 4 5 99 75 9 5 99 10 5 99 12 5 99)


(def multiinsertL (new old lat)
	(if (no lat) nil
		(is old (car lat))
			(cons new (cons (car lat) (multiinsertL new old (cdr lat))))
		(cons (car lat)
			(multiinsertL new old (cdr lat)))))
; #<procedure: multiinsertL>
(multiinsertL 99 5 '(5 1 3 4 5 75 9 5 10 5 12 5))
; (99 5 1 3 4 99 5 75 9 99 5 10 99 5 12 99 5)


(def multisubst (new old lat)
	(if (no lat) nil
		(is old (car lat))
			(cons new (multisubst new old (cdr lat)))
		(cons (car lat)
			(multisubst new old (cdr lat)))))
; #<procedure: multisubst>
(multisubst 99 5 '(5 1 3 4 5 7 5 9 5 10 5 12 5))
; (99 1 3 4 99 7 99 9 99 10 99 12 99)
