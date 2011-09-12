;;;; The Little Schemer - Chapter 7 - Friends and Relations

(def member? (a lat)
	(if (no lat) nil
		(or (is a (car lat))
			(member? a (cdr lat)))))

; arc> (member? 10 '(1 2 5 6 3 4 29 10 333))
; t
; arc> (member? 10 '(1 2 5 6 3 4 29 22 333))
; nil


(def set? (lat)
	(or (no lat)
		(and (~member? (car lat) (cdr lat))
			(set? (cdr lat)))))
		
; arc> (set? nil)
; t
; arc> (set? '(1 2 3 4))
; t
; arc> (set? '(1 2 3 4 5 6 7 8 1))
; nil



(def makeset (lat)
	(if (no lat) nil
		(member? (car lat) (cdr lat)) (makeset (cdr lat))
		(cons (car lat) (makeset (cdr lat)))))
		
; arc> (makeset '(1 7 4 6 1 99 1 99 3 4 6 1 99 45 99 1 1 1 1 76 1 99 1 1))
; (7 3 4 6 45 76 99 1)



(def subset? (sub lat)
	(if (no sub) t
		(and (member? (car sub) lat)
			(subset? (cdr sub) lat))))

; arc> (subset? '(3 7 4) '(5 6 7 9 12 4 17 18 3))
; t
; arc> (subset? '(3 7 0) '(5 6 7 9 12 4 17 18 3))
; nil
; arc> (subset? '(3 7 4) '(5 6 7 9 12 4 17 18 0))
; nil
; arc> (subset? nil '(5 6 7 9 12 4 17 18 0))
; t



(def eqset? (set1 set2)
	(and (subset? set1 set2)
		(subset? set2 set1)))



(def intersect? (set1 set2)
    (if (no set1) nil
        (or (member? (car set1) set2)
            (intersect? (cdr set1) set2))))

; arc> (intersect? '(1 2 3 4) '(5 8 2))
; t
; arc> (intersect? '(1 2 3 4) '(5 9 8))
; nil


(def intersect (set1 set2)
    (if (no set1) nil
        (member? (car set1) set2)
            (cons (car set1) (intersect (cdr set1) set2))
        (intersect (cdr set1) set2)))

; arc> (intersect '(1 2 3 4 5 6) '(9 8 7 6 5 4))
; (4 5 6)


(def union (set1 set2)
    (if (no set1) set2
        (member? (car set1) set2) (union (cdr set1) set2)
        (cons (car set1) (union (cdr set1) set2))))

; arc> (union '(1 2 3 4 5 6) '(9 8 7 6 5 4))
; (1 2 3 9 8 7 6 5 4)


(def intersect-all (sets)
    (if (no (cdr sets)) (car sets)
        (intersect (car sets) (intersect-all (cdr sets)))))

; arc> (intersect-all '((1 4 3 2) (2 3 6 7 9) (3 1 14 2)))
; (3 2)



;(def a-pair? ())

(def first (l) (car l))
;arc> (first '(33 44 55))
;33

(def second (l) (car (cdr l)))
;arc> (second '(33 44 55))
;44

(def build (s1 s2) (cons s1 (cons s2 nil)))
;arc> (build 33 44)
;(33 44)

(def third (l) (car (cdr (cdr l))))
;arc> (third '(33 44 55))
;55



;(def fun? (rel))

;(def revrel (rel))

;(def revpair (pair))

;(def fullfun? (f))

;(def one-to-one? (f))
