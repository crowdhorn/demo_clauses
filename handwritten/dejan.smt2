(set-logic HORN)

(declare-fun p0 (Int Int Int) Bool)
(declare-fun p1 (Int) Bool)
(declare-fun p2 (Int) Bool)

;; Initial state
(assert 
  (forall ((x Int) (y Int) (N Int)) 
    (p0 0 0 N)
  )
)

;; Loop 1: increase x and y up to N: (x + y) % 5 = 0
(assert
  (forall ((x Int) (y Int) (N Int))
    (=> (and (p0 x y N) (< x N)) (p0 (+ y 2) (+ x 3) N))
  )
)

(assert
  (forall ((x Int) (y Int) (N Int))
    (=> (and (p0 x y N) (>= x N)) (p1 (+ x y)))
  )
)

;; Loop 2: decrease x while > 0: x % 5 = 0
(assert
  (forall ((x Int) (y Int))
    (=> (and (p1 x) (> x 0)) (p1 (- x 5)))
  )
)

(assert
  (forall ((x Int) (y Int))
    (=> (and (p1 x) (<= x 0)) (p2 x))
  )
)

;; Property
(assert
  (forall ((x Int))
    (=> (p2 x) (= x 0))
  )
)

;; Check the property
(check-sat)
