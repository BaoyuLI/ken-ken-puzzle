;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "kenken-draw.rkt")


(define-struct puzzle (size board constraints))
;; A Puzzle is a (make-puzzle 
;;                Nat 
;;                (listof (listof (anyof Sym Nat Guess)))
;;                (listof (list Sym Nat (anyof '+ '- '* '/ '=))))
;; requires: See Assignment Specifications

(define-struct guess (symbol number))
;; A Guess is a (make-guess Sym Nat)
;; requires: See Assignment Specifications

;; Some useful constants
;; from assignment specification
(define puzzle1
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 'd 'e 'e)
    (list 'f 'd 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'd 5 '+)
    (list 'e 3 '-)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1
(define puzzle1partial
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
(define puzzle1partial2
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
;; but not yet verified 
(define puzzle1partial3
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; The solution to puzzle 1
(define puzzle1soln
  (make-puzzle
   4
   '((2 1 4 3)
     (3 2 1 4)
     (4 3 2 1)
     (1 4 3 2))
   empty))

;; wikipedia KenKen example
(define puzzle2
  (make-puzzle
   6
   '((a b b c d d)
     (a e e c f d)
     (h h i i f d)
     (h h j k l l)
     (m m j k k g)
     (o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (j 6 *)
     (k 7 +)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; The solution to puzzle 2
(define puzzle2soln
  (make-puzzle
   6
   '((5 6 3 4 1 2)
     (6 1 4 5 2 3)
     (4 5 2 3 6 1)
     (3 4 1 2 5 6)
     (2 3 6 1 4 5)
     (1 2 5 6 3 4))
   empty))

;; Tiny board
(define puzzle3
  (make-puzzle 
   2 
   '((a b) 
     (c b)) 
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))

(define puzzle3partial
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 1))
    (list 'c (make-guess 'b 2)))
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

;; a big board:  will take a *long* time without trying the bonus
(define puzzle4
  (make-puzzle
   9
   '((a a b c d e e f f)
     (g h b c d i j k l)
     (g h m m i i j k l)
     (n o m p p q q r s)
     (n o t u p v v r s)
     (n w t u x x y z z)
     (A w B C C C y D D)
     (A B B E E F G H I)
     (J J K K F F G H I))
   '((a 2 /)
     (b 11 +)
     (c 1 -)
     (d 7 *)
     (e 4 -)
     (f 9 +)
     (g 1 -)
     (h 4 /)
     (i 108 *)
     (j 13 +)
     (k 2 -)
     (l 5 -)
     (m 84 *)
     (n 24 *)
     (o 40 *)
     (p 18 *)
     (q 2 /)
     (r 2 -)
     (s 13 +)
     (t 10 +)
     (u 13 +)
     (v 2 -)
     (w 63 *)
     (x 1 -)
     (y 3 /)
     (z 2 /)
     (A 7 +)
     (B 13 +)
     (C 336 *)
     (D 1 -)
     (E 15 +)
     (F 12 *)
     (G 9 +)
     (H 5 -)
     (I 18 *)
     (J 3 /)
     (K 40 *))))
;; (find-blank puz) produces the position of the first blank
;; space in puz, or false if no cells are blank.  If the first constraint has
;; only guesses on the board, find-blank produces 'guess.  
;; find-blank: Puzzle -> (anyof Posn false 'guess)


(define (blank? brd sym)
  (cond
    [(empty? brd) false]
    [(empty? (first brd)) (blank? (rest brd) sym)]
    [(symbol? (first (first brd))) true]
    [else (blank?(append (list (rest (first brd)))
                               (rest brd))
                 sym)]))

(define (fb/acc brd const posn-sofar)
  (cond
    [(empty? const) false]
    [(empty? brd) false]
    [(empty? (first brd))
     (fb/acc (rest brd) const (make-posn 0
                                   (add1 (posn-y posn-sofar))))]
    [(blank? brd (first (first const)))
     (cond
       [(equal? (first (first brd)) (first (first const)))
        posn-sofar]
       [(not (equal? (first (first brd)) (first (first const))))
        (fb/acc (append (list (rest (first brd)))
                              (rest brd))
                const
                (make-posn (add1 (posn-x posn-sofar))
                           (posn-y posn-sofar)))]
       [else
        (cond
          [(and (guess? (first (first brd)))
                (symbol=? (guess-symbol (first (first brd)))
                         (first (first const))))
           'guess]
          [else (fb/acc (append (list (rest (first brd)))
                                (rest brd))
                        const
                        posn-sofar)])])]))

(define (find-blank puz)
  (fb/acc (puzzle-board puz) (puzzle-constraints puz) (make-posn 0 0)))

;; Tests:
(check-expect (find-blank (make-puzzle 1 '((r)) '((r 1 =)))) (make-posn 0 0))  ;; Test 001
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 002
                                       '((a 2 =) (b 1 =) (c 1 =) (d 2 =))))
              (make-posn 0 0))
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 003
                                       '((c 1 =) (b 1 =) (d 2 =) (a 2 =))))
              (make-posn 0 1))
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 004
                                       '((d 2 =) (c 1 =) (b 1 =) (a 2 =))))
              (make-posn 1 1))
(check-expect (find-blank (make-puzzle 2 '((a a) (a a)) '((a 6 +)))) (make-posn 0 0))  ;; Test 005
(check-expect (find-blank (make-puzzle 2 '((b a) (a a)) '((a 5 +) (b 1 =)))) (make-posn 1 0))  ;; Test 006
(check-expect (find-blank (make-puzzle 2 '((b b) (a a)) '((a 2 *) (b 3 +)))) (make-posn 0 1))  ;; Test 007
(check-expect (find-blank (make-puzzle 3 '((b c a) (a a a) (d a e))  ;; Test 008
                                       '((a 18 *) (b 1 =) (c 2 =) (d 3 =) (e 1 =))))
              (make-posn 2 0))
(check-expect (find-blank (make-puzzle 3 '((b b c) (b a a) (a a d))  ;; Test 009
                                       '((a 9 *) (b 5 +) (c 3 =) (d 2 =))))
              (make-posn 1 1))
(check-expect (find-blank (make-puzzle 3 (list (list 1 2 'd)  ;; Test 010
                                               (list (make-guess 'b 2) 3'b)
                                               (list 'b 'b 'b))
                                       '((b 12 *) (d 3 =))))
              (make-posn 2 1))
(check-expect (find-blank (make-puzzle 4 '((a a c c) (2 a d a) (3 a a a) (1 4 b b))  ;; Test 011
                                       '((d 1 =) (b 1 -) (a 20 +) (c 3 /))))
              (make-posn 2 1))
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 012
                                               (list 'z (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 'z (make-guess 'a 1) 'a 'a)
                                               (list 'z 'z 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -) (z 24 *))))
              (make-posn 2 2))
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 013
                                               (list 2 (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 3 'a 'a 'a)
                                               (list 1 4 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -))))
              (make-posn 1 2))
(check-expect (find-blank (make-puzzle 1 '((1)) empty)) false)  ;; Test 014
(check-expect (find-blank (make-puzzle 3 '((1 2 3) (2 3 1) (3 1 2)) empty)) false)  ;; Test 015
(check-expect (find-blank (make-puzzle 4 '((4 2 3 1) (2 3 1 4) (3 1 4 2) (1 4 2 3)) empty)) false)  ;; Test 016
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 018
                                               (list 2 (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 3 (make-guess 'a 1) (make-guess 'a 4) (make-guess 'a 2))
                                               (list 1 4 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -))))
              'guess)



;; (used-in-row puz pos) produces a list of numbers used in the same 
;; row as (x,y) position, pos, in the given puz.  
;; used-in-row: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-row puzzle1 (make-posn 1 1)) empty)

(define (used-in-row puz pos)
  (local [(define pick-row (list-ref (puzzle-board puz) (posn-y pos)))]
    (quicksort (filter (lambda (x) (not (symbol? x))) pick-row) <)))


;; Tests:
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))

;; (used-in-column puz pos) produces a list of numbers used in the same
;; column as (x,y) position, pos, in the given puz.  
;; used-in-column: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-column puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-column puzzle1partial (make-posn 2 2)) (list 1))
(check-expect (used-in-column puzzle1partial2 (make-posn 0 1)) (list 2))

(define (used-in-column puz pos)
  (local [(define col (map
             (lambda (x) (list-ref x (posn-x pos)))
                 (puzzle-board puz)))
          (define pick (map (lambda (y) (cond [(guess? y) (guess-number y)]
                                              [else y])) col))]
          (quicksort (filter (lambda (x) (not (symbol? x))) pick)
                     <)))


;; Tests:
(check-expect (used-in-column puzzle1partial3 (make-posn 1 1)) (list 2 3))
(check-expect (used-in-column puzzle1soln (make-posn 3 3)) (list 1 2 3 4))


;;This function may be useful as a helper for available-vals

;; (allvals n) produces a list of values from 1 to n
;; allvals: Nat -> (listof Nat)
;; Examples:
(check-expect (allvals 0) empty)
(check-expect (allvals 1) (list 1))

(define (allvals n) (build-list n (lambda (x) (add1 x))))

;; Tests:
(check-expect (allvals 3) (list 1 2 3))

;; (available-vals puz pos) produces a list of valid entries for the (x,y)  
;; position, pos, of the consumed puzzle, puz.  
;; available-vals: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (available-vals puzzle1 (make-posn 2 3)) '(1 2 3 4))

(define (available-vals puz pos)
  (filter (lambda (x) (and (not (member? x (used-in-column puz pos)))
                           (not (member? x (used-in-row puz pos)))))
          (allvals (puzzle-size puz))))
          

;; Tests:
(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))




;; (place-guess brd pos val) fills in the (x,y) position, pos, of the board, brd, 
;; with the a guess with value, val
;; place-guess: (listof (listof (anyof Sym Nat Guess))) Posn Nat 
;;              -> (listof (listof (anyof Sym Nat Guess)))
;; Examples:
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 3 2) 5)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g (make-guess 'g 5))
               (list 'f 'h 'i 'i)))

(define (place-guess brd pos val)
  (local [(define (guess-helper-lolos brd col row val)
            (cond [(zero? row)(cons (guess-helper-los (first brd) col val) (rest brd))]
                  [else (cons (first brd) (guess-helper-lolos (rest brd) col (sub1 row) val))]))
          
          (define (guess-helper-los row-of-brd col val)
            (cond [(zero? col)(cons (make-guess (first row-of-brd) val) (rest row-of-brd))]
                  [else (cons (first row-of-brd) (guess-helper-los (rest row-of-brd) (sub1 col) val))]))]
    (guess-helper-lolos brd (posn-x pos) (posn-y pos) val)))

;; Tests:
(check-expect (place-guess (puzzle-board puzzle1partial) (make-posn 0 0) 1)
   (list
    (list (make-guess 'a 1) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DO NOT CHANGE THIS FUNCTION;;;;;;;;;;;;;;;;;;;;;;;

;; (fill-in-guess puz pos val) fills in the (x,y) position, pos, of puz's board
;; with a guess wtih value, val
;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; Examples:
(check-expect (fill-in-guess puzzle1 (make-posn 3 2) 5)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd 'e 'e)
                (list 'f 'd 'g (make-guess 'g 5))
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))

(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))

;; Tests:
(check-expect (fill-in-guess puzzle3 (make-posn 0 0) 1)
              (make-puzzle
               2
               (list (list (make-guess 'a 1) 'b)
                     (list 'c 'b))
               '((b 3 +) 
                 (c 2 =)
                 (a 1 =))))



;; (guess-valid? puz) determines if the guesses in puz satisfy their constraint
;; guess-valid?: Puzzle -> Bool
;; Examples:

(define (guess-valid? puz)
  (local [;;(define gues-fil (filter guess? (puzzle-board puz)))
          (define gues-fil
            (foldr (lambda (x y)
                      (cond [(empty? (filter guess? x)) y]
                            [else (append (filter guess? x) y)]))
                   empty (puzzle-board puz)))
          (define cons-fil (first (filter (lambda (x)
                                     (symbol=? (first x)(guess-symbol (first gues-fil))))
                                   (puzzle-constraints puz))))]
    (cond [(symbol=? (third cons-fil) '=)(foldr (lambda (x y)(and (= (guess-number x) (second cons-fil)) y)) true gues-fil)]
          [(symbol=? (third cons-fil) '*)(= (second cons-fil)(foldr (lambda (x y)(* (guess-number x) y)) 1 gues-fil))]
          [(symbol=? (third cons-fil) '+)(= (second cons-fil)(foldr (lambda (x y)(+ (guess-number x) y)) 0 gues-fil))]
          [(symbol=? (third cons-fil) '-)(= (second cons-fil)(foldr (lambda (x y)(- (max (guess-number x) y)
                                                                                    (min (guess-number x) y)))
                                                                    0
                                                                    gues-fil))]
          [(symbol=? (third cons-fil) '/)(= (second cons-fil)(foldr (lambda (x y)(/ (max (guess-number x) y)
                                                                                    (min (guess-number x) y)))
                                                                    1
                                                                    gues-fil))])))
                                                     
;; Tests:
(check-expect (guess-valid? puzzle3partial) true)
 


;; (apply-guess puz) converts all guesses in puz into their corresponding numbers
;; and removes the first contraint from puz's list of contraints
;; apply-guess:  Puzzle -> Puzzle
;; Examples:

(define (apply-guess puz)
    (make-puzzle
     (puzzle-size puz)
     (map (lambda (y)  
            (map (lambda (x) (cond
                               [(guess? x) (guess-number x)]
                               [else x]))
                 y))
            (puzzle-board puz))
          (rest (puzzle-constraints puz))))

;; Tests:
(check-expect (apply-guess (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =))))  ;; Test 001
              (make-puzzle 1 '((1)) empty))
(check-expect (apply-guess (make-puzzle 3 (list (list 'b 'b 3)  ;; Test 002
                                                (list 'b 'a 'a)
                                                (list 'a 'a (make-guess 'd 2)))
                                        '((d 2 =) (b 4 *) (a 3 *))))
              (make-puzzle 3 (list (list 'b 'b 3)
                                   (list 'b 'a 'a)
                                   (list 'a 'a 2))
                           '((b 4 *) (a 3 *))))
(check-expect (apply-guess (make-puzzle 4 (list (list 'b (make-guess 'a 2) (make-guess 'a 3) 1)  ;; Test 003
                                                (list 'b 'b (make-guess 'a 1) 4)
                                                (list (make-guess 'a 3) (make-guess 'a 1) (make-guess 'a 4) (make-guess 'a 2))
                                                (list 'c 'c 2 (make-guess 'a 3)))
                                        '((a 19 +) (c 4 *) (b 2 /))))
              (make-puzzle 4 (list (list 'b 2 3 1)
                                   (list 'b 'b 1 4)
                                   (list 3 1 4 2)
                                   (list 'c 'c 2 3))
                           '((c 4 *) (b 2 /))))
(check-expect (apply-guess (make-puzzle 4 (list (list 4 2 'a 'a)  ;; Test 004
                                                (list 'b (make-guess 'c 3) 'a 4)
                                                (list 'b (make-guess 'c 1) (make-guess 'c 4) 2)
                                                (list 1 (make-guess 'c 4) (make-guess 'c 2) 3))
                                        '((c 96 *) (b 5 +) (a 3 *))))
              (make-puzzle 4 (list (list 4 2 'a 'a)
                                   (list 'b 3 'a 4)
                                   (list 'b 1 4 2)
                                   (list 1 4 2 3))
                           '((b 5 +) (a 3 *))))
(check-expect (apply-guess (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 005
                                                (list 'a (make-guess 'b 1) 2)
                                                (list 'a (make-guess 'b 3) 1))
                                        '((b 3 /) (a 8 +))))
              (make-puzzle 3 (list (list 'a 'a 3)
                                   (list 'a 1 2)
                                   (list 'a 3 1))
                           '((a 8 +))))



;; (neighbours puz) produces a list of next puzzles after puz in
;; the implicit graph
;; neighbours: Puzzle -> (listof Puzzle)
;; Examples:
(check-expect (neighbours puzzle3)
              (list 
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 1)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 2)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))))

(define (neighbours puz)
  (cond
    [(equal? (find-blank puz) false) empty]
    [(equal? 'guess (find-blank puz)) empty]
    [else 
     (filter (lambda (x)
            (guess-valid? x))
             (map
              (lambda (y)
                (fill-in-guess puzzle1
                               (find-blank puzzle1)
                               y))
              (available-vals puzzle1 (find-blank puzzle1))))]))
;; Tests:
(check-expect (neighbours puzzle2soln) empty)
(check-expect (neighbours puzzle3partial)
              (list 
               (make-puzzle
                2 
                (list
                 (list 'a 1)
                 (list 'c 2))
                '((c 2 =)
                  (a 1 =)))))  
(check-expect (neighbours (make-puzzle 1 '((a)) '((a 1 =))))  ;; Test 001
              (list (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =)))))

;; This is just the find-route function from Module 12, slides
;; 31-37.  (Read a bit ahead if you want the deatils.) The explicit
;; graph G has been removed, and the termination condition (the desired
;; destination) is when the puzzle is complete (that is, find-blank
;; returns false).

;; (solve-kenken orig draw-option) finds the solution to a KenKen puzzle,
;; orig, or returns false if there is no solution.  A visual representiation
;; of the solution may be draw depending on the value of draw-option
;; solve-kenken: Puzzle Sym -> (anyof Puzzle false)
;; requires:  draw-option is one of 'off, 'norm, 'slow, 'fast
;; Examples:
(check-expect (solve-kenken puzzle1 'off) puzzle1soln)

(define (solve-kenken orig draw-option)
  (local
    [(define setup (puzzle-setup orig draw-option))
     (define (solve-kenken-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else (local
                 [(define draw (draw-board (first to-visit) draw-option))]
                 (cond
                   [(boolean? (find-blank (first to-visit))) (first to-visit)]
                   [(member (first to-visit) visited)
                    (solve-kenken-helper (rest to-visit) visited)]
                   [else
                    (local [(define nbrs (neighbours (first to-visit)))
                            (define new (filter (lambda (x) (not (member x visited))) nbrs))
                            (define new-to-visit (append new (rest to-visit)))
                            (define new-visited (cons (first to-visit) visited))]
                      (solve-kenken-helper new-to-visit new-visited))]))]))]
    (solve-kenken-helper (list orig) empty)))

;; Tests:
(check-expect (solve-kenken puzzle3partial 'off) false)
;; The time special form shows you the number of milliseconds spent
;; evaluating the given expression.  The first number (cpu time) is
;; the important one.
(check-expect (time (solve-kenken puzzle2 'off)) puzzle2soln)
