module CFT.Splits

import CFT
import Data.Vect

addToCorrectBucket : (value : a)
                  -> {n : Nat}
                  -> (choice : Ty (TyFromNat n) [])
                  -> (vect : Vect n (List a))
                  -> Vect n (List a)
addToCorrectBucket value {n = 0} choice [] = []
addToCorrectBucket value {n = (S k)} (Left Unit) (y :: xs) = (value :: y) :: xs
addToCorrectBucket value {n = (S k)} (Right x) (y :: xs) = y :: addToCorrectBucket value x xs

-- Split a list into `n` lists using a function that allows you to map each element
-- to its `n`th bucket
splitN : (n : Nat) -> (p : a -> Ty (TyFromNat n) []) -> List a -> Vect n (List a)
splitN n p [] = replicate n []
splitN n p (x :: xs) = let check = p x 
                           rec = splitN n p xs in 
                           addToCorrectBucket x check rec

fromBool : Bool -> Ty (TyFromNat 2) [] 
fromBool True = Left Unit
fromBool False = Right (Left Unit)

isEven : Nat -> Bool
isEven Z = True
isEven (S k) = not (isEven k)

splitTwoTest : Splits.splitN 2 (Splits.fromBool . Splits.isEven) [1 .. 4] === [[2,4], [1,3]]
splitTwoTest = Refl

--
-- DEFINING POLYNOMIALS
-- 
-- The goal is to have a type of polynomials that we are going to analyse and
-- see if we can split them into polynomials with 1 solution, 2 solutions or 0 solutions
record Polynomial where
  constructor MkPoly
  x2 : Int -- x squared term
  x : Int -- x term
  c : Int -- constant term

-- A polynomial a * x^2 + b * x + c has
-- 2 solutions if b^2 - 4*a*c > 0
-- 1 solution if b^2 - 4*a*c === 0
-- 0 solutions if b^2 - 4*a*c < 0
solutions : Polynomial -> Ty (TyFromNat 3) []
solutions (MkPoly a b c) = 
  let v = b * b - 4 * a * c in
      if v > 0 then Left Unit -- 2 solutions 
               else if v == 0 then Right (Left Unit) -- 1 solution
               else Right (Right (Left Unit)) -- no solutions

poly1 : Polynomial
poly1 = MkPoly 2 1 3 -- 0 solutions

poly2 : Polynomial
poly2 = MkPoly (-1) 2 3 -- 2 solutions 

poly3 : Polynomial 
poly3 = MkPoly 1 2 1 -- 1 solution

split3Test : splitN 3 Splits.solutions [Splits.poly1, Splits.poly2, Splits.poly3] 
         === [[Splits.poly2],[Splits.poly3],[Splits.poly1]]
split3Test = Refl
