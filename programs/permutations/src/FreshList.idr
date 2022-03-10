||| Fresh lists, a variant of Catarina Coquand's contexts in "A
||| Formalised Proof of the Soundness and Completeness of a Simply
||| Typed Lambda-Calculus with Explicit Substitutions"
|||
||| Based directly on Agda's fresh lists:
||| http://agda.github.io/agda-stdlib/Data.List.Fresh.html
module FreshList

import public Data.So

%default total

-- Boolean "relation"
public export
BRel : Type -> Type
BRel a = a -> a -> Bool

infix 4 #, ##, #?

public export
data FreshVect : Nat -> (a : Type) -> (neq : BRel a) -> Type

-- The boolean version
public export
(##) : {neq : BRel a} -> (x : a) -> (xs : FreshVect l a neq) -> Bool
-- The type version
public export
(#) : {neq : BRel a} -> (x : a) -> (xs : FreshVect l a neq) -> Type

public export
data FreshVect : Nat -> (a : Type) -> (neq : BRel a) -> Type where
  Nil  : FreshVect Z a neq
  (::) : (x : a) -> (xs : FreshVect l a neq) ->
         {auto 0 fresh : x # xs} ->
         FreshVect (S l) a neq

%name FreshVect xs, ys, zs

x ##    []     = True
x ## (y :: xs) = (x `neq` y) && (x ## xs)

x # xs = So (x ## xs)

export
toList : FreshVect l a p -> List a
toList [] = []
toList (x :: xs) = x :: toList xs

export
Show a => Show (FreshVect l a p) where
  show = show . toList

parameters
  {0 A : Type} {0 Aneq : BRel A}
  {0 B : Type} {0 Bneq : BRel B}
  (F : A -> B)
  (Injectivity : (x,y : A) -> So (x `Aneq` y) -> So (F x `Bneq` F y))

  public export
  map : FreshVect l A Aneq -> FreshVect l B Bneq

  public export
  0 mapFreshness : {x : A} -> (ys : FreshVect l A Aneq) ->
                   x # ys -> F x # map ys

  map     []              = []
  map ((x :: xs) {fresh}) = (F x :: map xs) {fresh = mapFreshness xs fresh}

  mapFreshness    []              _
    = Oh
  mapFreshness (y :: ys) p
    = let (x_fresh_y, x_fresh_ys) = soAnd p in
      andSo (Injectivity _ _ x_fresh_y, mapFreshness ys x_fresh_ys)

namespace View
  public export
  data Empty : FreshVect Z a neq -> Type where
    Nil : Empty Nil

  public export
  data NonEmpty : FreshVect (S l) a neq -> Type where
    IsNonEmpty : NonEmpty ((x :: xs) {fresh})

public export
length : FreshVect l a neq -> Nat
length [] = 0
length (x :: xs) = 1 + length xs

public export
fromMaybe : Maybe a -> (l ** FreshVect l a neq)
fromMaybe Nothing  = (Z ** [])
fromMaybe (Just x) = (1 ** [x])

-- I don't include replicate since freshness ought not to be
-- reflexive, but feel free to add it if you need it

public export
uncons : FreshVect (S l) a neq -> (a , FreshVect l a neq)
uncons (x :: xs) = (x, xs)

public export
head : (xs : FreshVect (S l) a neq) -> a
head (x :: xs) = x

public export
tail : (xs : FreshVect (S l) a neq) -> FreshVect l a neq
tail (x :: xs) = xs

public export
0 (.freshness) : (xs : FreshVect (S l) a neq) ->
                 head xs # tail xs
(((x :: xs) {fresh}).freshness) = fresh

-- Freshness lemmata
parameters (0 x : a) (ys : FreshVect (S l) a neq)
  public export
  0 headFreshness : x # ys -> So (x `neq` head ys)

  public export
  0 tailFreshness : x # ys -> x # (tail ys)

headFreshness x (y :: ys) freshness
  = fst (soAnd freshness)
tailFreshness x (y :: ys) freshness
  = snd (soAnd freshness)

public export
take : (n : Nat) -> FreshVect (n + m) a neq -> FreshVect n a neq
public export
0 takeFreshness : (n : Nat) -> (xs : FreshVect (n + m) a neq) -> y # xs -> y # take n {m} xs

take 0     xs                  = []
take (S n) ((x :: xs) {fresh}) = (x :: take n xs) {fresh = takeFreshness {m} n xs fresh}

takeFreshness  0          xs  fresh = Oh
takeFreshness (S n) (x :: xs) fresh =
  let (y_neq_x, y_fresh_xs) = soAnd fresh in
  andSo (y_neq_x, takeFreshness n xs y_fresh_xs)

public export
drop : (n : Nat) -> FreshVect (n + m) a neq -> FreshVect m a neq
drop 0           xs  = xs
drop (S n) (x :: xs) = drop n xs

-- The Agda lib has more general takeWhile, dropWhile, filter
-- involving decidable predicts, but we follow the Idris stdlib and
-- use the special case for Bool

-- public export
-- takeWhile : (pred : a -> Bool) -> FreshVect l a neq -> (m ** FreshVect m a neq)
-- public export
-- 0 takeWhileFreshness : (pred : a -> Bool) -> (xs : FreshVect l a neq) ->
--   y # xs -> y # (takeWhile pred xs).snd
--
-- takeWhile pred     []              = (Z ** [])
-- takeWhile pred ((x :: xs) {fresh}) = case pred x of
--   True  => let (n ** rec) = takeWhile pred xs
--              ; res = (x :: rec) {fresh = takeWhileFreshness pred xs fresh} in
--              (S n ** res)
--   False => (Z ** [])

-- takeWhileFreshness  pred []           fresh
--   = Oh
-- takeWhileFreshness  pred (x :: xs) fresh with (pred x)
--  takeWhileFreshness pred (x :: xs) fresh | True
--   = let (y_fresh_x, y_fresh_xs) = soAnd fresh in
--     andSo (y_fresh_x, takeWhileFreshness pred xs y_fresh_xs)
--  takeWhileFreshness pred (x :: xs) fresh | False
--   = Oh
--
-- public export
-- dropWhile : (pred : a -> Bool) -> FreshVect a neq -> FreshVect a neq
--
-- public export
-- 0 dropWhileFreshness : (pred : a -> Bool) -> (xs : FreshVect a neq) ->
--   y # xs -> y # dropWhile pred xs
--
--
-- dropWhile pred     []              = []
-- dropWhile pred ((x :: xs) {fresh}) = case pred x of
--   True  => (x :: dropWhile pred xs) {fresh = dropWhileFreshness pred xs fresh}
--   False => []
--
-- dropWhileFreshness  pred    []     fresh = Oh
-- dropWhileFreshness  pred (x :: xs) fresh with (pred x)
--  dropWhileFreshness pred (x :: xs) fresh | False
--    = Oh
--  dropWhileFreshness pred (x :: xs) fresh | True
--    = let (y_neq_x, y_fresh_xs) = soAnd fresh in
--      andSo (y_neq_x, dropWhileFreshness pred xs y_fresh_xs)
--
-- public export
-- filter : (pred : a -> Bool) -> FreshVect a neq -> FreshVect a neq
-- public export
-- 0 filterFreshness : (pred : a -> Bool) -> (xs : FreshVect a neq) ->
--   y # xs -> y # filter pred xs
--
-- filter pred     []              = []
-- filter pred ((x :: xs) {fresh}) = case pred x of
--   False => filter pred xs
--   True  => (x :: filter pred xs) {fresh = filterFreshness pred xs fresh}
--
-- filterFreshness  pred    []     fresh = Oh
-- filterFreshness  pred (x :: xs) fresh with (pred x)
--  filterFreshness pred (x :: xs) fresh | False
--    = let (y_neq_x, y_fresh_xs) = soAnd fresh in
--      filterFreshness pred xs y_fresh_xs
--  filterFreshness pred (x :: xs) fresh | True
--    = let (y_neq_x, y_fresh_xs) = soAnd fresh in
--      andSo (y_neq_x, filterFreshness pred xs y_fresh_xs)

-- Todo: move `decSo : (b : Bool) -> Dec (So b)` to base
public export
decideFreshness : {neq : BRel a} ->
                  (x : a) -> (ys : FreshVect l a neq) ->
                  Dec (x # ys)
decideFreshness x ys with (x ## ys)
  decideFreshness x ys | True  = Yes Oh
  decideFreshness x ys | False = No absurd

public export
foldl : (f : b -> a -> b) -> b -> FreshVect l a neq -> b
foldl f x [] = x
foldl f x (y :: ys) = foldl f (x `f` y) ys

public export
foldr : (f : a -> b -> b) -> b -> FreshVect l a neq -> b
foldr f x [] = x
foldr f x (val :: vals) = (val `f` foldr f x vals)

namespace String
  public export
  (##) : BRel String
  s ## t = (s /= t)

