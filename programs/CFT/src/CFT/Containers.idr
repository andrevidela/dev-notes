module CFT.Containers

record SCont (n : Nat) where
    constructor MkSCont
    shapes : Type
    seq : (x, y : shapes) -> Dec (x = y)
    positions : shapes -> Type


-- SExt : {n : Nat} -> SCont n -> Vect n Type -> Type
-- SExt (MkSCont shapes seq pos) x =
--     DPair shapes (\s => ((i : Fin n) -> (Vect (pos i s) (index i x))))


-- ex : {n : Nat} -> String
-- ex {n} = "hello" ++ show n
-- 
-- 
-- main : IO ()
-- main = putStrLn ex
