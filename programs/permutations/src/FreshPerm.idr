
module FreshPerm

import FreshList
import Data.Fin
import Data.Vect

||| An arrangement is a list of fins of a given length
||| and range.
public export
Arrangement : Nat -> Nat -> Type
Arrangement len range = FreshVect len (Fin range) (/=)

||| A permutation is an arrangement where each fin appears n times
||| and the fins range from 0 to n
public export
Permutation : Nat -> Type
Permutation n = Arrangement n n

weakenInj : (x : Fin k) -> (y : Fin k) -> So (not (x == y)) -> So (not (weaken x == weaken y))
weakenInj FZ FZ z = z
weakenInj FZ (FS x) z = z
weakenInj (FS x) FZ z = z
weakenInj (FS x) (FS y) z = weakenInj x y z

easyNeq : (y : Fin n) -> So ((Fin.last /= (Fin.weaken y)))
easyNeq FZ = Oh
easyNeq (FS x) = easyNeq x

freshWeakend : (fs : Arrangement l r) ->
               So ((Fin.last) ## map Fin.weaken {Bneq=(/=)} weakenInj fs)
freshWeakend [] = Oh
freshWeakend (x :: xs) = andSo (easyNeq _, freshWeakend xs)

reversePermutation : (n : Nat) -> Permutation n
newFresh : (n : Nat) -> So (Fin.last {n}
                           ## map Fin.weaken {Bneq = (/=)} FreshPerm.weakenInj (reversePermutation n))

reversePermutation 0 = []
reversePermutation (S k) =
    (::) (last {n=k})
       (FreshList.map weaken {Bneq = (/=)} weakenInj (reversePermutation k)) {fresh = newFresh k}

newFresh n = freshWeakend (reversePermutation n)

flip : {a, b : Fin n} -> So (a /= b) -> So (b /= a)
flip {a = FZ} {b = FZ} x = x
flip {a = FZ} {b = (FS y)} x = x
flip {a = (FS y)} {b = FZ} x = x
flip {a = (FS y)} {b = (FS z)} x = flip x

export
append : (f : Fin n) -> (fs : Arrangement l n) -> {0 notIn : So (f ## fs)} -> Arrangement (S l) n
freshlyAppend : {x, f : Fin n} ->
                {xs : Arrangement l n} ->
                {fneq : So (f ## xs)} ->
                (notEq : So (x /= f)) ->
                (fresh : So (x ## xs)) ->
                So (x ## append {notIn = fneq} f xs)

append f [] = [f]
append f ((x :: xs) {fresh}) = let 0 p = soAnd notIn in
                                   (::) x (append f {notIn = snd p} xs)
                                   {fresh = freshlyAppend (flip $ fst p) fresh}

freshlyAppend notEq fresh {xs = []} = andSo (notEq, Oh)
freshlyAppend notEq fresh {xs = (y :: xs)} =
  let (a, b) = soAnd fresh in
      andSo (a, freshlyAppend notEq b)

export
reverse : Arrangement l n -> Arrangement l n

0 freshlyReversed : (x, xs : _) -> So (x ## xs) -> So (x ## FreshPerm.reverse xs)

reverse [] = []
reverse ((::) x xs {fresh}) = append x (reverse xs) {notIn = freshlyReversed x xs fresh}

freshlyReversed x [] y = Oh
freshlyReversed x (z :: xs) y with (soAnd y)
  freshlyReversed x (z :: xs) y | (w, v) =
    freshlyAppend {xs= reverse xs} {f=z} w (freshlyReversed ? xs v)

export
identityPermutation : (n : Nat) -> Permutation n
identityPermutation n = reverse (reversePermutation n)

extractVal : (Fin (S n)) -> Vect (S n) a -> (a, Vect n a)
extractVal FZ (x :: xs) = (x, xs)
extractVal (FS FZ) (y :: (x :: xs)) = (x, y :: xs)
extractVal (FS (FS x)) (y :: (z :: xs)) with (extractVal (FS x) (z :: xs))
  extractVal (FS (FS x)) (y :: (z :: xs)) | (k, ks) = (k, y :: ks)

applyPermutation : (1 _ : Permutation n) -> (1 _ : Vect n a) -> Vect n a
applyPermutation [] [] = []
applyPermutation (x :: xs) (y :: ys) =
  let (val, res) = extractVal x (y :: ys) in
      val :: applyPermutation ?kek res


