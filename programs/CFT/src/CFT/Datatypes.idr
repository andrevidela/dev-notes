module Datatypes

import CFT

public export
TNat : {n : _ } -> CFT n
TNat = µ (One + VZ)
-- data Nat = Zero | Succ Nat

public export
TList : {n : _} -> CFT (S n)
TList = µ (One + (var 1 * var 0))

public export
TTree : {n : _} -> CFT (S n)
TTree = µ (var 1 + (var 0 * var 0))

public export
TRoseTree : {n : _} -> CFT (S n)
TRoseTree = µ (var 1 * µ (One + (var 1 * var 0)))

public export
TRoseTree' : {n : _} -> CFT (S n)
TRoseTree' = µ (var 1 * App TList (var 0))

public export
zero : Ty TNat t
zero = In (Left Unit)

public export
succ : Ty TNat t -> Ty TNat t
succ x = In (Right (Top x))

public export
cons : Ty a t -> Ty TList (a :: t) -> Ty TList (a :: t)
cons x y = In (Right (Pair (Pop (Top x)) (Top y)))

public export
tLen : Ty TList t -> Ty TNat t
tLen (In (Left Unit)) = zero
tLen (In (Right (Pair x (Top y)))) = succ (tLen y)

public export
fromNat : Nat -> Ty TNat t
fromNat 0 = zero
fromNat (S k) = succ (fromNat k)

public export
toNat : Ty TNat t -> Nat
toNat (In (Left Unit)) = Z
toNat (In (Right (Top x))) = S (toNat x)

public export
plus : (m, n : Ty TNat t ) -> Ty TNat t
plus (In (Left Unit)) n = n
plus (In (Right (Top x))) n = succ (plus x n)
