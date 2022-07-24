module PartList

import Data.Linear
import Data.List.Elem
import Data.List.Quantifiers
import Data.Vect.Quantifiers
import Data.Linear.Notation
import Data.Vect
import Data.Fin
import FreshList

%default total

data RT = Linear Type | Erased Type
data Use = Available | Consumed

IsConsumed : Use -> Type
IsConsumed = (===) Consumed

IsAvailable : Use -> Type
IsAvailable = (===) Available

0 GetTy : RT -> Type
GetTy (Linear ty) = ty
GetTy (Erased ty) = ty

data IsErased : RT -> Type where
  Er : IsErased (Erased ty)

data IsUsable : RT -> Type where
  Us : IsUsable (Linear ty)

data PartList : (ts : List RT) -> Type where
  Empty : PartList []
  Some : (1 _ : t) -> (1 _ : PartList ts) -> PartList (Linear t :: ts)
  None : (0 _ : t) -> (1 _ : PartList ts) -> PartList (Erased t :: ts)

toRT : Type -> Use -> RT
toRT x Available = Linear x
toRT x Consumed = Erased x

0 ElemList : List Use -> Type -> Type
ElemList xs x = PartList (map (toRT x) xs)

pop : PartList (Linear t :: ts) -> LPair t (PartList (Erased t :: ts))
pop (Some x y) = x # None x y

data In : PartList ts -> Type where
  Here : In (Some x xs)
  ThereS : In xs -> In (Some y xs)
  ThereE : In xs -> In (None y xs)

-- Get the type pointed
0 FromPL : (ls : PartList ts) -> In ls -> Type
FromPL (Some x {t} xs) Here = t
FromPL (Some y xs) (ThereS x) = FromPL xs x
FromPL (None y xs) (ThereE x) = FromPL xs x

-- if we have a ponter to a part list we have a pointer to the list of types
0 AsElem : (ls : PartList ts) -> (ins : In ls) -> (Elem (Linear (FromPL ls ins)) ts)
AsElem (Some x {t} xs) Here = Here
AsElem (Some y xs) (ThereS x) = There (AsElem xs x)
AsElem (None y xs) (ThereE x) = There (AsElem xs x)

index : (ls : PartList ts) -> (ins : In ls) -> FromPL ls ins
index (Some x xs) Here = x
index (Some y xs) (ThereS x) = index xs x
index (None y xs) (ThereE x) = index xs x

0 Consume : (ts : List RT) -> Elem (Linear t) ts -> List RT
Consume (Linear t :: xs) Here = Erased t :: xs
Consume (y :: xs) (There x) = y :: Consume xs x

indexLinear : (1 ls : PartList ts) -> (1 ins : In ls) -> LPair (FromPL ls ins) (PartList (Consume ts (AsElem ls ins)))
indexLinear (Some x xs) Here = x # None x xs
indexLinear (Some y xs) (ThereS x) = let a # b = indexLinear xs x in a # Some y b
indexLinear (None y xs) (ThereE x) = let a # b = indexLinear xs x in a # None y b

lconcat : String -@ String -@ String
lconcat = believe_me Prelude.String.(++)

printAll : (1 _ : PartList tys) -> All IsUsable tys -> All (\t => (1 _ : GetTy t) -> String) tys -> String
printAll Empty [] [] = ""
printAll (Some x w) (Us :: v) (f :: s) = let r = f x; r' = printAll w v s in r `lconcat` r'
printAll (None _ _) (Us :: _) (_ :: _) impossible

Permutation : Nat -> Type
Permutation n = Vect n (Fin n)

0 Length : PartList ts -> Nat
Length Empty = Z
Length (Some x y) = S (Length y)
Length (None x y) = S (Length y)

makeIndices : (ls : PartList ts) -> Permutation (Length ls)
makeIndices Empty = []
makeIndices (Some x y) = FZ :: map FS (makeIndices y)
makeIndices (None x y) = FZ :: map FS (makeIndices y)

--move : (ls : PartList ts) -> (idx : In ls) -> (target : PartList ts') -> (Consume

at : List a -> Nat -> Maybe a
at (x :: xs) Z = Just x
at (x :: xs) (S n) = at xs n
at _ _ = Nothing

insertAt : List a -> Nat -> a -> Maybe (List a)
-- We're expecting to find something but we found nothing
insertAt [] 0 x = Nothing
-- replace the element
insertAt (y :: xs) 0 x = Just (x :: xs)
-- We're expecting to find something but we found nothing
insertAt [] (S k) x = Nothing
-- Keep inserting
insertAt (y :: xs) (S k) x = (y ::) <$> insertAt xs k x

naive : (ref : List a) ->
        (current : Nat) ->
        (permutations : List Nat) ->
        (target : List (Maybe a)) ->
        Maybe (List a)
naive ref _ [] target = traverse id target -- we're done going through our indicies, return the accumulator
naive ref n (p :: ps) target = do
  v <- at ref n
  insertAt target p (Just v) >>= naive ref (S n) ps

testNaive : PartList.naive ["hello", "!", "world"] Z [0, 2, 1] [Nothing, Nothing, Nothing] === Just ["hello", "world", "!"]
testNaive = Refl

testNaiveFlip : PartList.naive ["hello", "!"]  Z [1, 0] [Nothing, Nothing] === Just ["!", "hello"]
testNaiveFlip = Refl

testNaive1 : PartList.naive ["hello"] Z [0] [Nothing] === Just ["hello"]
testNaive1 = Refl

strengthen : {n : _} -> Fin (S n) -> Maybe (Fin n)
strengthen {n = S _} FZ = Just FZ
strengthen {n = S _} (FS p) with (PartList.strengthen p)
  strengthen (FS _) | Nothing = Nothing
  strengthen (FS _) | Just q  = Just $ FS q
strengthen _ = Nothing

finS : {n : Nat} -> Fin n -> Fin n
finS {n = S _} x = case PartList.strengthen x of
    Nothing => FZ
    Just y => FS y

vector : {n : Nat} ->
         (ref : Vect n a) ->
         (current : Fin n) ->
         (permutations : List (Fin n)) ->
         (target : Vect n (Maybe a)) ->
         Maybe (Vect n a)
vector ref _ [] target = traverse id target -- we're done going through our indicies, return the accumulator
vector ref n (p :: ps) target =
  let v = Vect.index n ref
      vs = replaceAt p (Just v) target
  in vector ref (PartList.finS n) ps vs

testVector : PartList.vector ["hello", "!", "world"] FZ [0, 2, 1] [Nothing, Nothing, Nothing] === Just ["hello", "world", "!"]
testVector = Refl

testVectorFlip : PartList.vector ["hello", "!"]  FZ [1, 0] [Nothing, Nothing] === Just ["!", "hello"]
testVectorFlip = Refl

testVector1 : PartList.vector ["hello"] FZ [0] [Nothing] === Just ["hello"]
testVector1 = Refl

testVectorFail : PartList.vector ["hello", "!", "world"] FZ [0, 2] [Nothing, Nothing, Nothing] === Nothing
testVectorFail = Refl

next : {n : Nat} -> (current, until : Fin n) -> Maybe (Fin n)
next {n= S n} FZ FZ = Nothing
next {n= S 0} FZ (FS x) = absurd x
next {n= S (S k)} FZ (FS x) = Just (FS FZ)
next {n= S n} (FS x) FZ = Nothing
next {n= S 0} (FS x) (FS y) = absurd x
next {n= S (S k)} (FS x) (FS y) =
  FS <$> next x y

testNext : next {n = 4} 0 3 === Just 1
testNext = Refl

testNext2 : next {n = 4} 3 3 === Nothing
testNext2 = Refl

testNext3 : next {n = 7} 3 3 === Nothing
testNext3 = Refl

testNext4 : next {n = 7} 2 3 === Just 3
testNext4 = Refl

namespace VectorIndex
  vector : {n : Nat} ->
           (ref : Vect (S n) a) ->
           (current : Fin (S n)) ->
           (permutations : Vect (S n) (Fin (S n))) ->
           (target : Vect (S n) (Maybe a)) ->
           Maybe (Vect (S n) a)
  vector ref current permutations target = let
    value = index current ref
    newPos = index current permutations
    overridden = replaceAt newPos (Just value) target
    in case PartList.next current last of
            Nothing => traverse id overridden -- we're done, we can't increment any more
            (Just x) => assert_total $ vector ref x permutations overridden

  failing
    testVectorFail : VectorIndex.vector ["hello", "!", "world"] FZ [0, 2] [Nothing, Nothing, Nothing] === Nothing

  testVectorFail2 : VectorIndex.vector ["hello", "!"]  FZ [1, 1] [Nothing, Nothing] === Nothing
  testVectorFail2 = Refl

  testVector : VectorIndex.vector ["hello", "!", "world"] FZ [0, 2, 1] [Nothing, Nothing, Nothing] === Just ["hello", "world", "!"]
  testVector = Refl

  testVectorFlip : VectorIndex.vector ["hello", "!"]  FZ [1, 0] [Nothing, Nothing] === Just ["!", "hello"]
  testVectorFlip = Refl


  testVector1 : VectorIndex.vector ["hello"] FZ [0] [Nothing] === Just ["hello"]
  testVector1 = Refl

namespace FreshIndex
  vector : {n : Nat} ->
           (ref : Vect (S n) a) ->
           (current : Fin (S n)) ->
           (permutations : FreshVect (S n) (Fin (S n)) (/=)) ->
           (target : Vect (S n) (Maybe a)) ->
           Maybe (Vect (S n) a)
  vector ref current permutations target = let
    value = index current ref
    newPos = FreshList.index current permutations
    overridden = replaceAt newPos (Just value) target
    in case PartList.next current last of
            Nothing => traverse id overridden -- we're done, we can't increment any more
            (Just x) => assert_total $ vector ref x permutations overridden
  failing
    testVectorFail : FreshIndex.vector ["hello", "!", "world"] FZ [0, 2] [Nothing, Nothing, Nothing] === Nothing

  failing "Can't find an implementation for So (FS FZ ## [FS FZ])"
    testVectorFail2 : FreshIndex.vector ["hello", "!"]  FZ [1, 1] [Nothing, Nothing] === Nothing

  testVector : FreshIndex.vector ["hello", "!", "world"] FZ [0, 2, 1] [Nothing, Nothing, Nothing] === Just ["hello", "world", "!"]
  testVector = Refl

  testVectorFlip : FreshIndex.vector ["hello", "!"]  FZ [1, 0] [Nothing, Nothing] === Just ["!", "hello"]
  testVectorFlip = Refl

  testVector1 : FreshIndex.vector ["hello"] FZ [0] [Nothing] === Just ["hello"]
  testVector1 = Refl

namespace UseVector
  data UsageVect : Vect n Use -> Type -> Type where
    Nil : UsageVect [] a
    Value : a -@ UsageVect xs a -@ UsageVect (Available :: xs) a
    Spent : (0 _ : a) -> UsageVect xs a -@ UsageVect (Consumed :: xs) a

  AllSpent : Vect n Use -> Type
  AllSpent = All IsConsumed

  AnyValue : Vect n Use -> Type
  AnyValue = Any IsAvailable

  -- linearly index the usage vector
  indexl : {0 us : Vect n Use} -> (1 idx : Fin n) -> (1 _ : UsageVect us a) -> (0 _ : Vect.index idx us === Available) -> LPair a (UsageVect (replaceAt idx Consumed us) a)
  indexl {us = Available :: us} FZ     (Value x y) Refl = x # Spent x y
  indexl {us = Consumed  :: us} FZ     (Spent x y) Refl impossible
  indexl {us = Available :: us} (FS n) (Value x y) prf = let (val # rest) = UseVector.indexl {us} n y prf in (val # Value x rest)
  indexl {us = Consumed  :: us} (FS n) (Spent x y) prf = let (val # rest) = UseVector.indexl {us} n y prf in (val # Spent x rest)

  0 Index : {0 n : Nat} -> {0 us : Vect n Use} -> Fin n -> UsageVect us a -> a
  Index FZ (Value x y) = x
  Index FZ (Spent x y) = x
  Index (FS x) (Value y z) = Index x z
  Index (FS x) (Spent y z) = Index x z

  moveInto : {0 us : Vect n Use} -> (1 _ : a) -> (1 target : UsageVect us a) -> (1 idx : Fin n) -> (0 _ : Vect.index idx us === Consumed) -> UsageVect (replaceAt idx Available us) a
  moveInto {us = Consumed  :: us} x (Spent _ xs) FZ Refl = Value x xs
  moveInto {us = Consumed  :: us} x (Spent v vs) (FS y) prf = Spent v $ moveInto {us} x vs y prf
  moveInto {us = Available :: us} x (Value v vs) (FS y) prf = Value v $ moveInto {us} x vs y prf

  move : {0 n : Nat} -> {0 us, vs : Vect n Use} ->
         (1 from : Fin n) -> (1 source : UsageVect us a) -> (0 _ : Vect.index from us === Available) ->
         (1 to : Fin n) -> (1 target : UsageVect vs a) -> (0 _ : Vect.index to vs === Consumed) ->
         LPair (UsageVect (replaceAt from Consumed us) a) (UsageVect (replaceAt to Available vs) a)
  move from source prf to target prf1 =
    let (v # vs) = indexl from source prf
        res = moveInto v target to prf1
    in (vs # res)

  moveIndex : {0 n : Nat} -> {0 us, vs, fs : Vect n Use} ->
              (1 from : Fin n) -> (1 source : UsageVect us a) -> (0 _ : Vect.index from us === Available) ->
              (1 from2 : Fin n) -> (0 _ : from === from2) ->
              (1 permutations : UsageVect fs (Fin n)) -> (0 _ : Vect.index from fs === Available) ->
              (1 target : UsageVect vs a) -> (0 _ : Vect.index (Index from permutations) vs === Consumed) ->
              LPair (LPair
                    (UsageVect (replaceAt from Consumed us) a)
                    -- The value at the target index is now available since we just put a value into it
                    (UsageVect (replaceAt (Index from permutations) Available vs) a))
                    (UsageVect (replaceAt from Consumed fs) (Fin n))
  moveIndex {vs} from source prf0 from2 prf1 permutations prf2 target prf3 = let
    (idx # vs) = indexl from permutations prf2
    prfIdx : (idx === (Index from permutations)) = believe_me Refl
    r1 # r2 = move from2 source (rewrite sym prf1 in prf0) idx target (rewrite prfIdx in Refl `trans` prf3)
    in (rewrite prf1 in r1 # (rewrite sym prf1 in rewrite sym prfIdx in r2)) # vs


  swap : {0 us, is : Vect 2 Use} -> (1 source : UsageVect us a) -> (_ : All IsAvailable us) ->  (1 target : UsageVect is a) -> (_ : All IsConsumed is) -> UsageVect us a
  swap (Value w (Value x [])) (Refl :: (Refl :: [])) (Spent v (Spent s [])) (Refl :: (Refl :: [])) = Value x (Value w [])
  swap (Value w (Value x [])) (Refl :: (Refl :: [])) (Spent v (Value s t)) (Refl :: (Refl :: [])) impossible
  swap (Value w (Value x [])) (Refl :: (Refl :: [])) (Value v s) (Refl :: []) impossible
  swap (Value w (Spent x v)) (Refl :: (Refl :: [])) target y impossible
  swap (Spent w v) (Refl :: (z :: [])) target y impossible

  -- destination-style map
  mapTarget : {0 n : Nat} -> {0 us, vs : Vect n Use} ->
              (f : a -@ b) ->
              UsageVect us a -@ All IsAvailable us -@ -- The vector we map across
              UsageVect vs b -@ All IsConsumed vs  -@ -- The vector we fill up
              UsageVect us b
  mapTarget f [] [] xs [] = xs
  mapTarget f (Value x v) y (Value z s) (Refl :: t) impossible
  mapTarget f (Spent x v) y (Value z s) (Refl :: t) impossible
  mapTarget f (Spent x xs) (Refl :: ys) (Spent z zs) ws impossible
  -- Here we need a way to reuse the memory space from `Spent`
  mapTarget f (Value x xs) (y :: ys) (Spent _ zs) (Refl :: ws) = Value (f x) (mapTarget f xs ys zs ws)

  swap2 : {0 us, is, ps : Vect 2 Use} ->
          (1 source : UsageVect us a) -> (_ : All IsAvailable us) -> -- The source vector
          (1 target : UsageVect is a) -> (_ : All IsConsumed is)  -> -- The destination vector
          (1 permutations : UsageVect us (Fin 2)) ->                 -- The permutation we use
          UsageVect us a
  swap2 source (x :: (z :: [])) target y (Value p1 (Value p2 [])) = let
    (r1 # r2) # r3 = moveIndex FZ source Refl FZ Refl (Value p1 (Value p2 [])) _ target _
    (s1 # s2) # s3 = moveIndex 1 r1 Refl 1 Refl r3 _ r2 _
    in ?end
  swap2 _ (_ :: (Refl :: _)) _ _ (Value _ (Spent _ _)) impossible
  swap2 source (Refl :: z) target y (Spent w v) impossible











