;;;; The Little Schemer - Chapter 9 - ...and Again, and Again, and Again...

; NOTE: This chapter is pretty hardcore:
; - Natural and unnatural recursion
; - Total and partial functions
; - The Halting Problem
; - The Y Combinator


(def pick (i lat)
    (if (no lat) nil
        (is i 0) (car lat)
        (pick (- i 1) (cdr lat))))

(pick 0 '(11 22 33 44))
(pick 1 '(11 22 33 44))
(pick 2 '(11 22 33 44))
(pick 3 '(11 22 33 44))
(pick 4 '(11 22 33 44))



(def looking (a lat)
    (keep-looking a (pick 0 lat) lat))

(def keep-looking (a sorn lat)
    (if (number? sorn) (keep-looking a (pick sorn lat) lat)
        (is sorn a)))

; keep-looking is an exampe of "unnatural" recursion - it doesn't recur on any part of lat

; Functions like 'looking' are called "partial functions". The functions we've seen up to this point are called "total functions".

; Themost extreme example of unnatural recursion - the most unnatural function: a simple infinite loop...
(def eternity (x) (eternity x))



; Wouldn't it be great if we could write a function that tells us whether
;  some function returns with a value for every argument? Let's try...



;;;;;;;;;;;;
;
; TODO - Finish the stuff explaining the halting problem
;
;;;;;;;;;;;;




(def add1 (x) (+ 1 x))

(def length (l)
    (if (no l) 0
        (add1 (length (cdr l)))))

(length '(1 2 3 4 5 6 7))

; Here's a question: could We define 'length' if we couldn't name it?
;  Well... can we create an anonymous function that returns the length of just the empty list?
;   No problem...
(= length-0
    (fn (l)
        (if (no l) 0
            (add1 (eternity (cdr l))))))

(length-0 nil)


; What about a function for lists with one or fewer items?
(= length-1
    (fn (l)
        (if (no l) 0
            (add1
                ((fn (l)  ; Note that this is just 'length-0' from before...
                    (if (no l) 0
                        (add1 (eternity (cdr l)))))
                 (cdr l))))))

(length-1 nil)
(length-1 '(1))


; For a function with two or fewer items, we just follow the same scheme...
(= length-2
    (fn (l)
        (if (no l) 0
            (add1   ; Similar to what we did before, this is just length-1...
                ((fn (l)
                     (if (no l) 0
                         (add1   ; ...and again...
                             ((fn (l)
                                  (if (no l) 0
                                      (add1 (eternity (cdr l)))))
                              (cdr l)))))
                 (cdr l))))))

(length-2 nil)
(length-2 '(1))
(length-2 '(1 2))


; So, if we could write an infinite function, we could write length-infinite,
;  which would determine the length of all lists we can make...

; We can't write an infinite function. But we *can* abstract out
;  some commonalities that we've seen thus far...

(= length-0
    ((fn (length) ; We abstract 'eternity' out as a parameter, as this produces slightly more readable code:
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))
     eternity))

(= length-1
    ((fn (f)
        (fn (l)
            (if (no l) 0
                (add1 (f (cdr l))))))
     ((fn (g)
         (fn (l)
             (if (no l) 0
                 (add1 (g (cdr l))))))
      eternity)))

(= length-2
    ((fn (f)
        (fn (l)
            (if (no l) 0
                (add1 (f (cdr l))))))
     ((fn (g)
         (fn (l)
             (if (no l) 0
                 (add1 (g (cdr l))))))
      ((fn (h)
        (fn (l)
            (if (no l) 0
                (add1 (h (cdr l))))))
     eternity))))


; Well, OK... that's a *little* clearer, but there's still a lot of duplicate code -
;  we're constantly repeating something that sort of looks like our length function.
;  Let's name a function that creates a length-like function - this seems like noise
;  for length-0...

(= length-0
    ((fn (mk-length)
        (mk-length eternity))
     (fn (length)
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))))

; ...but it makes the code *much* nicer for length-1 and beyond:    
(= length-1
    ((fn (mk-length)
        (mk-length
            (mk-length eternity)))
     (fn (length)
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))))

(= length-2
    ((fn (mk-length)
        (mk-length
            (mk-length
                (mk-length eternity))))
     (fn (length)
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))))

(= length-3
    ((fn (mk-length)
        (mk-length
            (mk-length
                (mk-length
                    (mk-length eternity)))))
     (fn (length)
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))))


; Now, for any given N, as long as our function doesn't go past N, we don't actually *care*
;  about the 'eternity' function; we just need *something* - we could just as well
;   pass in mk-length itself:

(= length-0
    ((fn (mk-length)
        (mk-length mk-length))
     (fn (length)
        (fn (l)
            (if (no l) 0
                (add1 (length (cdr l))))))))

; ...and let's rename 'length' to 'mk-length', to make clearer that we're always just passing in mk-length:

(= length-0
    ((fn (mk-length)
        (mk-length mk-length))
     (fn (mk-length)
        (fn (l)
            (if (no l) 0
                (add1 (mk-length (cdr l))))))))


; Now check THIS out:

(= length-1
    ((fn (mk-length)
        (mk-length mk-length))
     (fn (mk-length)
        (fn (l)
            (if (no l) 0
                (add1 ((mk-length eternity) (cdr l))))))))

(length-1 '(apple)))
; 1

; Very cool!! But what just happened?? Well, let's walk through it...

; We have an s-expression, with a function and one argument.
; The function takes a single function as an argument, and applies it to itself.
; The argument is a function that takes a 'finish-the-job' function as an argument,
;  and - in this case - return a single argument function that tries to find the
;  length of a list, using that 'finish-the-job' function that was passed in.


;;;;;;;;;;;;;;;;;
;
; TODO - Finish this section...
;
;;;;;;;;;;;;;;;;;



; Hmm... So then couldn't we keep going for arbitrarily long lists
;  if we just passed mk-length to itself instead of eternity?
; Yes!
(= length
    ((fn (mk-length)
        (mk-length mk-length))
     (fn (mk-length)
        (fn (l)
            (if (no l) 0
                (add1 ((mk-length mk-length) (cdr l))))))))

(length '(0 1 3 4 5 6 32 1 4 3 5 2 2 2 4 5 6 7 32 23 6 67 7 ))
; 23

; This is cool, but we've sort of lost our original length function. Can we get it get back?




;;;;;;;;;;;
;
; TBD
;
;;;;;;;;;;;





; Ladies and gentlemen, the applicative-order Y combinator:
(def Y (le)
    ((fn (f) (f f))
     (fn (f)
         (le (fn (x) ((f f) x))))))

; Let's test it out, just to be sure...
(= length
    (Y
        (fn (len)
            (fn (l)
                (if (no l) 0
                    (add1 (len (cdr l))))))))

(length nil)
; 0
(length '(0))
; 1
(length '(0 1))
; 2
(length '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
; 15

; Sweet!!!