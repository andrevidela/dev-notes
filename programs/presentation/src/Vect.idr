module Vect

import Data.Vect

cars : Vect 0 String
cars = []

main : IO ()
main = printLn (head cars)
