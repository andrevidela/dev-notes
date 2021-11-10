module CFT.Zippers

import CFT
import Datatypes

namespace Zipper
  public export
  data ZList a = MkZipper (List a) (List a)
  
  moveRight : ZList a -> ZList a
  moveRight ls@(MkZipper xs []) = ls
  moveRight (MkZipper xs (x :: ys)) = MkZipper (x :: xs) ys
  
  moveLeft : ZList a -> ZList a
  moveLeft ls@(MkZipper [] ys) = ls
  moveLeft (MkZipper (x :: xs) ys) = MkZipper xs (x :: ys)
  
  cycleR : ZList a -> ZList a
  cycleR (MkZipper xs []) = MkZipper [] (reverse xs)
  cycleR (MkZipper xs (x :: ys)) = MkZipper (x :: xs) ys

namespace ZipperDesc
  public export
  TZip : {n : _} -> CFT (S n)
  TZip = TList * TList 
  
  tMoveRight : Ty TZip (a :: t) -> Ty TZip (a :: t)
  tMoveRight (Pair x (In (Left Unit))) = Pair x (In (Left Unit))
  tMoveRight (Pair x (In (Right (Pair (Pop (Top y)) (Top z)))))  = Pair (cons y x) z

toList : Ty TList (a :: t) -> List (Ty a t)
toList (In (Left Unit)) = []
toList (In (Right (Pair (Pop (Top x)) (Top y)))) = x :: toList y

fromList : List (Ty a t) -> Ty TList (a :: t)
fromList [] = In (Left Unit)
fromList (x :: xs) = cons x (fromList xs)

pairInj : (f : Ty TList (a :: t) -> Ty TList (a :: t)) -> fromList (toList y) = y -> CFT.fromList (CFT.toList (f y)) = f y
pairInj f prf = ?pairInj_rhs

toFromList : (x : Ty (Mu (One + (VS VZ * VZ))) (a :: t)) -> fromList (toList x) = x
toFromList (In (Left Unit)) = Refl
toFromList (In (Right (Pair x (Top y)))) = let result = toFromList y in 
                                             pairInj (In . Right . Pair x . Top) result

fromToList : (x : List (Ty a t)) -> CFT.toList (fromList x) = x
fromToList [] = Refl
fromToList (x :: xs) = let rec = fromToList xs in cong (x :: ) rec

ListTListIso : Iso (List (Ty a t)) (Ty TList (a :: t))
ListTListIso = MkIso
  { to = fromList
  , from = toList
  , toFrom = toFromList
  , fromTo = fromToList
  }


fromZList : ZList (Ty a t) -> Ty TZip (a :: t)
fromZList (MkZipper xs ys) = Pair (fromList xs) (fromList ys)

toZList : Ty TZip (a :: t) -> ZList (Ty a t) 
toZList (Pair x y) = MkZipper (toList x) (toList y) 

toFromZList : (x : Ty TZip (a :: t)) -> fromZList (toZList x) = x
toFromZList (Pair x y) = ?toFromZList_rhs_1

ZListTZipIso : Iso (ZList (Ty a t)) (Ty TZip (a :: t))
ZListTZipIso = MkIso 
  { to = fromZList
  , from = toZList
  , toFrom = toFromZList
  , fromTo = ?aiod
  }

derive : {n : _} -> Fin n -> CFT n -> CFT n
derive FZ     VZ = One
derive (FS x) VZ = Zero
derive FZ     (VS y) = Zero
derive (FS x) (VS y) = Zero
derive n      (App f x) = App (derive (FS n) f) x
                        + App (derive FZ f) x * derive n x
derive n      Zero = Zero
derive n      One = Zero
derive n      (a + b) = derive n a + derive n b
derive n      (a * b) = derive n a * b + a * derive n b
derive n      (Mu f) = App TList (App (derive FZ f) (Mu f))
                     * App (derive (FS n) f) (Mu f)

DerivedList : CFT 1
DerivedList = derive FZ TList
