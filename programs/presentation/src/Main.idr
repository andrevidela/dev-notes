module Main

import Data.Vect
import Date


ReturnType : Bool -> Type
ReturnType True = String
ReturnType False = Int

depends : (b : Bool) -> ReturnType b
depends False = 42
depends True = "hello"


main : IO ()
main = let format = formatString "yyyy/MM/dd"
       in printLn format
