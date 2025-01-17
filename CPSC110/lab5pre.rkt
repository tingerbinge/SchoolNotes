;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5pre) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

(define-struct chequing (name balance))
;; Chequing is (make-chequing String Number)
;; interp. the name of the account holder and the balance in the account

(define C1 (make-chequing "Jill" 1000))

(define (fn-for-chequing cheq)
  (... (cheqing-name cheq)
       (cheqing-balance cheq)))

;; Compound Data


(define-struct savings  (name balance fee))
;; Savings is (make-savings String Number Number)
;; interp. the name of the account holder, the balance in the account,
;; and the fee applied to each withdrawal

(define S1 (make-savings "Bob" 500 10))

(define (fn-for-savings sav)
  (... (savings-name sav)
       (savings-balance sav)
       (savings-fee sav)))

;; Compound Data


;; Account is one of:
;; - Chequing
;; - Savings
;; interp. type of bank account

(define A1 C1)
(define A2 S1)

(define (fn-for-account acct)
  (cond [(chequing? acct) (fn-for-chequing acct)]
        [(savings? acct) (fn-for-savings acct)]))

;; References to other data definitions



;; Account Number -> Boolean
;; determines if there are enough funds in an account to withdraw num dollars
(check-expect (enough-funds? A1  500) true)
(check-expect (enough-funds? A1 1500) false)
(check-expect (enough-funds? A2  100) true)
(check-expect (enough-funds? A2  500) false)
#;
(define (enough-funds? acct num) ; STUB
  true)`

(define (enough-funds? acct num)
  (cond [(savings? acct)
         (>= (- (savings-balance acct) num (savings-fee acct)) 
             0)]
        [(chequing? acct)
         (>= (- (chequing-balance acct) num) 
             0)]))

;; Chequing Number -> Boolean
;; determines if there are enough funds in a chequing account to withdraw num dollars
(check-expect (enough-chequing? C1  500) true)
(check-expect (enough-chequing? C1 1000) true)
(check-expect (enough-chequing? C1 1500) false)
#;
(define (enough-chequing? cheq num) ;STUB
  true)

(define (enough-chequing? cheq num)
  (>= (- (chequing-balance cheq) num) 0))


;; Savings Number -> Boolean
;; determines if there are enough funds in a savings account to withdraw num dollars
(check-expect (enough-savings? S1 100) true)
(check-expect (enough-savings? S1 490) true)
(check-expect (enough-savings? S1 500) false)
#;
(define (enough-savings? sav num) ;STUB
  true)

(define (enough-savings? sav num)
  (>= (- (savings-balance sav) num (savings-fee sav)) 0))
