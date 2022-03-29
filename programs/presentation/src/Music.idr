module Music

import Data.Vect

data Heterogeneous :  Vect n Type -> Type where
  Empty : Heterogeneous []
  Cons : (val : a) -> Heterogeneous types -> Heterogeneous (a :: types)

indexAt : (idx : Fin n) -> {0 types : Vect n Type} ->
          Heterogeneous types -> index idx types
indexAt FZ (Cons val x) = val
indexAt (FS y) (Cons val x) = indexAt y x

example : Heterogeneous [String, Int, Type]
example = Cons "hello" (Cons 43 (Cons Nat Empty))

append : Heterogeneous xs -> Heterogeneous ys -> Heterogeneous (xs ++ ys)
append Empty y = y
append (Cons val x) y = Cons val (append x y)


























{-

indexAt : (idx : Fin n) -> {0 types : Vect n Type} ->
          Heterogeneous types -> index idx types
indexAt FZ (Cons val x) = val

indexAt (FS y) (Cons val x) = indexAt y x

append : Heterogeneous xs -> Heterogeneous ys -> Heterogeneous (xs ++ ys)
append Empty y = y
append (Cons val x) y = Cons val (append x y)





