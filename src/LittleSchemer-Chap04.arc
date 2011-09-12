;;;; The Little Schemer - Chapter 4 - Numbers Games

(def tup+ (tup1 tup2)
	(if (and (no tup1) (no tup2)) nil
		(cons 
			(+ (or (car tup1) 0) 
				(or (car tup2) 0))
			(tup+ (cdr tup1) (cdr tup2)))))
			
			