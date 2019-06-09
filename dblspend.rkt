#! /usr/local/bin/racket
#lang racket/base


(require racket/cmdline)
(require racket/format)


(define (factorial n)
  (letrec ([_factorial
            (lambda (n a)
              (cond [(not (positive? n)) a]
                    [else (_factorial (sub1 n) (* n a))]))])
    (_factorial n 1)))


(define (prob-of-attack q z)
  (let* ([p (- 1 q)]
         [L (* z (/ q p))]
         [N (add1 z)]
         [E (exp 1)]
         [Q (lambda (k) (cond [(< p q) 1]
                              [(> p q) (expt (/ q p) (- N k))]))]
         [B (lambda (k) (/ (* (expt L k) (expt E (- L))) (factorial k)))])
    (- 1 (for/fold ([S 0])
                   ([k (in-range (add1 N))])
                   (+ S (* (- 1 (Q k)) (B k)))))))


(define verbose-mode (make-parameter #f))
(define attack-power (make-parameter 0.1))
(define conf-depth (make-parameter 6))


(module+ main
  (command-line
   #:once-each
   [("-v" "--verbose")
    "Enable verbose mode"
    (verbose-mode #t)]
   [("-q" "--attacker-power")
    q
    "Probability of an attacker mining a block"
    (attack-power (string->number q))]
   [("-z" "--conf-depth")
    z
    "Number of blocks after which a transaction is marked as `safe`"
    (conf-depth (string->number z))])
  (when (verbose-mode)
    (printf "#> q: ~a, z: ~a ~n" (attack-power) (conf-depth)))
  (let ([x (prob-of-attack (attack-power) (conf-depth))])
    (printf "~a~n" (~r x #:precision 12))))
