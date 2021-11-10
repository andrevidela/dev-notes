module CFT.DependentLens

public export
record DepLens (s, a : Type) (t : s -> Type) (b : a -> Type) where
  constructor MkDepLens
  get : s -> a
  set : (es : s) -> b (get es) -> t es
