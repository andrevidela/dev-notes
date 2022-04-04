module Interact

import Data.IORef
import Control.Monad.State

fn1 : Int -> State Int ()
fn1 arg = do v <- get
             put (v + arg)

fn2 : Int -> Int -> State Int Int
fn2 a b = do v <- get
             if v < a then put b *> (pure b)
                      else put v *> (pure v)

fn3 : State Int ()
fn3 = put 100


eval : (ref : IORef st) => State st a -> IO a
eval x = do state <- readIORef ref
            let (newState, v) = runState state x
            writeIORef ref newState
            pure v
