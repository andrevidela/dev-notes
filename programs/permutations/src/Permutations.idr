module Permutations

import Data.Fin
import Data.Vect
import Decidable.Equality

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
find x (More v rest) with (decEq x v)
  find x (More x rest) | Yes Refl = True
  _ | No _ = find x rest

-- append : (insert: Fin n) -> (p : Permutation l n) -> {auto notIn : find insert p = False} -> Permutation (S l) n
--
-- findPrf : {x, v : _} -> (p : Permutation l n) -> find x p = False -> find v p = False -> Not (v = x) -> find x (append v p) = False
-- findPrf Empty prf prf1 prf2 with (decEq v x)
--   _ | Yes yes = void (prf2 yes)
--   findPrf Empty prf prf1 prf2 | No no = ?whui
-- findPrf (More y p) prf prf1 prf2 = ?findPrf_rhs_1

-- append v Empty = More v Empty -- {notIn = Refl}
-- append insert (More pop p {notIn = prf}) {notIn = prf2} with (decEq insert pop) proof prf3
--   append insert (More insert p {notIn = prf}) | Yes Refl = absurd prf2
--   _ | No con = More pop (append insert p {notIn = prf2}) {notIn = findPrf p prf prf2 con}
--
--
-- reverse : Permutation l n -> Permutation l n
-- reverse Empty = Empty
-- reverse (More v p {notIn}) = append v {notIn = ?revNotIn notIn} (reverse p)
--

weaken : Permutation l n -> Permutation l (S n)
findWeaken : {v, p : _} -> find v p = False -> find (Fin.weaken v) (Permutations.weaken p) = False

weaken Empty = Empty
weaken (More v p {notIn = prf}) = More (weaken v) (weaken p) {notIn = findWeaken prf}

findWeaken prf with (weaken v)
  findWeaken prf | FZ with (weaken p)
    findWeaken prf | FZ | Empty = Refl
    findWeaken prf | FZ | (More x y {notIn = prf2}) = ?rest_rhst_0_rhs0_1
  findWeaken prf | (FS x) = ?rest_rhst_1



reversePermutation : (l : Nat) -> Permutation l l
reversePermutation 0 = Empty
reversePermutation (S k) = More ?reversePermutation_rhs_1 {notIn = ?notFound} (weaken $ reversePermutation k)


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

