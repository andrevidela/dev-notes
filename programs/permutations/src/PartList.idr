module PartList

import Data.Linear
import Data.List.Elem
import Data.List.Quantifiers
import Data.Linear.Notation
import Data.Vect
import Data.Fin

data RT = Linear Type | Erased Type

0 GetTy : RT -> Type
GetTy (Linear ty) = ty
GetTy (Erased ty) = ty

data IsErased : RT -> Type where
  Er : IsErased (Erased ty)

data IsAvailable : RT -> Type where
  Us : IsAvailable (Linear ty)

data PartList : (ts : List RT) -> Type where
  Empty : PartList []
  Some : (1 _ : t) -> (1 _ : PartList ts) -> PartList (Linear t :: ts)
  None : (0 _ : t) -> (1 _ : PartList ts) -> PartList (Erased t :: ts)

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

printAll : (1 _ : PartList tys) -> All IsAvailable tys -> All (\t => (1 _ : GetTy t) -> String) tys -> String
printAll Empty [] [] = ""
printAll (Some x w) (Us :: v) (f :: s) = let r = f x; r' = printAll w v s in r `lconcat` r'
printAll (None _ _) (Us :: _) (_ :: _) impossible

Permutation : Nat -> Type
Permutation n = Vect n (Fin n)

Indexed : (ts : List RT) -> PartList ts -> List RT
Indexed [] Empty = []
Indexed ((Linear t) :: xs) (Some x z) = Linear ?Indexed_rhs_3 :: Indexed xs z
Indexed ((Erased t) :: xs) (None x z) = ?Indexed_rhs_4



makeIndicies : (1 ls : PartList ts) -> PartList (Indexed ts ls)









