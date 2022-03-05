module Permutations

import Data.Vect

%default total

namespace Vect
  public export
  data LVect : Nat -> Type -> Type where
    Nil : LVect Z a
    (::) : (1 _ : a) -> (1 _ : LVect n a) -> LVect (S n) a

  public export
  append : (1 _ : a) -> (1 _ : LVect n a) -> LVect (S n) a
  append v [] = [v]
  append v (x :: xs) = x :: append v xs

  public export
  reverse : (1 _ : LVect n a) -> LVect n a
  reverse [] = []
  reverse (x :: y) = x `append` reverse y

  -- public export
  Permutation : Nat -> Type -> Type
  Permutation n a = (1 ls : LVect n a) -> LVect n a

  public export
  Permutation' : Nat ->  Type
  Permutation' n = (a : Type) -> (ls : Vect n a) -> Vect n a

namespace List
  public export
  data LList : Type -> Type where
    Nil : LList a
    (::) : (1 _ : a) -> (1 _ : LList a) -> LList a

  reverse : (1 _ : LList a) -> LList a
  reverse [] = []
  reverse (x :: y) = x :: reverse y

  Permutation : Type -> Type
  Permutation a = (1 ls : LList a) -> LList a

data Permutation : (length, range : Nat) -> Type where
find : Fin n -> Permutation l n -> Bool


data Permutation : (length, range : Nat) -> Type where
    Empty : Permutation 0 n
    More : (v : Fin n) -> (p : Permutation l n)
    -> {auto notIn : (find v p) = False} -> Permutation (S l) n

find v Empty = False
find x (More v rest) = case x == v of True => True ; False => find x rest

append : (v : Fin n) -> (p : Permutation l n) -> {auto notIn : find v p = False} -> Permutation (S l) n
findPrf : {x, v : _} -> (p : Permutation l n) -> find x p = False -> find v p = False -> x == v = False -> find x (append v p) = False
findPrf Empty prf prf1 prf2 with (x == v) proof p0
  findPrf Empty prf prf1 prf2 | False = ?findPrf_rhs_0_rhs0_0
  findPrf Empty prf prf1 prf2 | True = absurd prf2
findPrf (More y p) prf prf1 prf2 = ?findPrf_rhs_1

append v Empty = More v Empty -- {notIn = Refl}
append x (More v p {notIn = prf}) {notIn = prf2} with (x == v) proof prf3
  _ | True =  absurd prf2
  _ | False = More v (append x p {notIn = prf2}) {notIn = findPrf ?n ?m ?b ?nii}


reverse : Permutation l n -> Permutation l n
reverse Empty = Empty
reverse (More v p {notIn}) = append v {notIn = ?revNotIn notIn} (reverse p)



range : (n : Nat) -> Vect n (Fin n)
range 0 = []
range (S k) = FZ :: map FS (range k)

FindIndex : Fin n -> Vect n (Fin n) -> Maybe (Fin n)

findAlways : (i : Fin n) -> IsJust (FindIndex i (range n) )
findAlways FZ = ?findAlways_rhs_1
findAlways (FS x) = ?findAlways_rhs_2

Indices : Nat -> Type
Indices n = Vect n (Fin n)


revertIndex : Indices n -> Indices n
revertIndex xs = ?revertIndex_rhs

fromPerm : {n : Nat} -> Vect.Permutation' n -> Indices n
fromPerm f = f (Fin n) (range {len=n})

fromIndex : Indices n -> Vect.Permutation' n
fromIndex xs a ls = map (\idx => index idx ls) (xs)

invert : {n : Nat} -> Vect.Permutation' n -> Vect.Permutation' n
invert = fromIndex . revertIndex . fromPerm

