module Data.Iso

public export 
record Iso (a, b : Type) where
  constructor MkIso
  to : a -> b
  from : b -> a
  toFrom : (x : b) -> to (from x) === x
  fromTo : (x : a) -> from (to x) === x

-- TODO: transitive and reflexive for ISO
