module CFT

import Data.List
import Data.Fin
import Data.Maybe
import Data.Nat
import Data.Vect

infixr 1 ~>

namespace Telescope

  public export
  data Tel : Nat -> (f : Nat -> Type) -> Type where
    Nil : Tel 0 f
    (::) : (t : f n) -> Tel n f -> Tel (S n) f

public export
data CFT : Nat -> Type where
  --- variables
  VZ : CFT (S n)
  VS : CFT n -> CFT (S n)

  -- Void
  Zero : CFT n

  -- Unit
  One : CFT n

  -- fixpoint
  Mu : CFT (S n) -> CFT n

  -- Algebraic definitions
  (+) : (a, b : CFT n) -> CFT n
  (*) : (a, b : CFT n) -> CFT n
  -- (~>) : (a, b : CFT n) -> CFT n
  App : CFT (S n) -> CFT n -> CFT n

%inline
public export
µ : CFT (S n) -> CFT n
µ = Mu

public export
var : Fin n -> CFT n
var FZ = VZ
var (FS x) = VS (var x)

public export
TyFromNat : Nat -> CFT n
TyFromNat 0 = Zero
TyFromNat (S k) = One + TyFromNat k

interface Universe u where
  El : u -> Type

public export
data Ty : CFT n -> Tel n CFT -> Type where
  Top : Ty t t' -> Ty VZ (t :: t')
  Pop : Ty t t' -> Ty (VS t) (s :: t')
  Left : Ty s t' -> Ty (s + t) t'
  Right : Ty t t' -> Ty (s + t) t'
  Def : Ty f (a :: t) -> Ty (App f a) t
  -- Fun : {k : CFT n} -> (k -> Ty t t') -> Ty (k ~> t) t'
  Unit : Ty One t
  Pair : Ty s t' -> Ty t t' -> Ty (s * t) t'
  In : Ty f (Mu f :: t') -> Ty (Mu f) t'

data Morph : (s, t : Tel n f) -> Type where

    ML : Morph s s

    MF : (f : Ty s s' -> Ty t t')
      -> (phi : Morph s' t')
      ----------------------------
      -> Morph (s :: s') (t :: t')

    Mµ : Morph s' t' -> Morph (t :: s') (t :: t')

gMap : Morph s' t' -> Ty t s' -> Ty t t'
gMap ML         (Top x) = Top x
gMap (MF f phi) (Top x) = Top (f x)
gMap (Mµ phi)   (Top x) = Top (gMap phi x)
gMap ML         (Pop x) = Pop x
gMap (MF f phi) (Pop x) = Pop (gMap phi x)
gMap (Mµ phi)   (Pop x) = Pop (gMap phi x)
gMap phi        (Left x) = Left (gMap phi x)
gMap phi        (Right x) = Right (gMap phi x)
gMap phi        (Def x) = Def (gMap (Mµ phi) x)
gMap phi        Unit = Unit
gMap phi        (Pair x y) = Pair (gMap phi x) (gMap phi y)
gMap phi        (In x) = In (gMap (Mµ phi) x)

