;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |prelab7 - 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;; Simple file systems, model 1:

;; File is String
;; interp. the string represents the file's name

;; Directory (Dir) is one of:
;;  - empty
;;  - (cons File Dir)
;;  - (cons Dir Dir)
;; interp: directories can contain files and other directories


;; PRE-LAB EXERCISES:
;;
;; (1) Define at least 4 examples of Dir here. As usual, start with a
;;     base case, make sure to have examples at least 2 deep and 2 wide.
(define dir1 empty)
(define dir2 (cons 1 empty))
(define dir3 (cons 1 (cons 2 empty)))
(define dir4 (cons (cons 1 empty)
                   (cons 2 empty)))


;; (2) Assume you are in the process of defining a 1 argument function
;;     operating on a Dir. Write the template for that function here:
;;
#;
(define (fn-for-dir dir)
  (cond [(empty? dir) (...)]
        [(string? (first dir)) 
         (fn-for-file (first dir))]
        [(dir? (first dir))
         (fn-for-dir (first dir))(fn-for-dir (rest dir))]))
#;
(define (fn-for-file file)
  (... file))

;
;; (3) Print out this file, and draw reference/call arrows on the types
;;     comments and function templates. Label each arrow with one of:
;;      (R) reference to another non-primitive type
;;      (SR) self-reference to the same non-primitive type
;;      (MR) reference to another non-primitive type that forms
;;           part of a mutual reference cycle
;;
;;    If you cannot print the file, hand write the above type comments
;;    on a piece of paper and label them.




;;
;; IN LAB EXERCISES:
;;
;; Using the data definitions in this file (model 1), design the
;; function how-many-dir, that consumes a Dir and produces the number
;; of files in the dir tree.
;;
(check-expect (how-many-dir empty) 0)
(check-expect (how-many-dir (cons "file" empty)) 1)
(check-expect (how-many-dir (cons (cons "file" empty) (cons "file" empty))) 2)
(check-expect (how-many-dir (cons "file" (cons "file" empty))) 2)
#;
(define (how-many-dir dir)
  (cond [(empty? dir) 0]
        [else
         (+  (if (string? (first dir)) 
                 (add-file (first dir))
                 (how-many-dir (first dir)))
             (how-many-dir (rest dir)))]))

(define (how-many-dir dir)
  (cond [(empty? dir) 0]
        [(string? (first dir))
         (+ 1
            (how-many-dir (rest dir)))]
        [else
         (+ (how-many-dir (first dir)) 
            (how-many-dir (rest dir)))]))
