;;;; The Little Schemer - Chapter 8 - Lambda the Ultimate

(def rember-f (test? a l)
	(if (no l) nil
		(test? a (car l)) (cdr l)
		(cons (car l) (rember-f test? a (cdr l)))))



; Let's get a flavor of what is called "currying":
(def def-is-x? (x)
    (fn (a) (is a x)))

; Note what's happening - we've defined a new function, and x has come along for the ride!
; arc> (= is-1? (def-is-x? 1))
; #<procedure>
; arc> (is-1? 2)
; nil
; arc> (is-1? "fub")
; nil
; arc> (is-1? 1)
; t


(def def-rember (test?)
    (fn (a l)
	    (if (no l) nil
    		(test? a (car l)) (cdr l)
    		(cons (car l) ((def-rember test?) a (cdr l))))))

; Note the bit of ugliness that we have now - it's there because we don't know how to recurse on an anonymous function

; arc> (= rember (def-rember is))
; #<procedure>
; arc> (rember 10 '(1 2 4 10 9))
; (1 2 4 9)

(def def-insertL (test?)
    (fn (new old l)
        (if (no l) nil
            (test? (car l) old) (cons new (cons old (cdr l)))
            (cons (car l) ((def-insertL test?) new old (cdr l))))))

; arc> (= insertL (def-insertL is))
; #<procedure>
; arc> (insertL 77 33 '(1 33 4 5 6 33 99))
; (1 77 33 4 5 6 33 99)

(def def-insertR (test?)
    (fn (new old l)
        (if (no l) nil
            (test? (car l) old) (cons old (cons new (cdr l)))
            (cons (car l) ((def-insertR test?) new old (cdr l))))))

; #<procedure: def-insertR>
; arc>  (= insertR (def-insertR is))
; #<procedure>
; arc> (insertR 77 33 '(1 33 4 5 6 33 99))
; (1 33 77 4 5 6 33 99)

(def def-insert (test? build)
    (fn (new old l)
        (if (no l) nil
            (test? (car l) old) (build new old l)
            (cons (car l) ((def-insert test? build) new old (cdr l))))))

; arc>  (= insertL (def-insert is (fn (new old l) (cons new (cons old (cdr l))))))
; #<procedure>
; arc> (insertL 77 33 '(1 33 4 5 6 33 99))
; (1 77 33 4 5 6 33 99)

; arc> (= insertR (def-insert is (fn (new old l) (cons old (cons new (cdr l))))))
; #<procedure>
; arc> (insertR 77 33 '(1 33 4 5 6 33 99))
; (1 33 77 4 5 6 33 99)

