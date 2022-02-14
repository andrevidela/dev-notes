
# 6 Open-Servers
  - [ ] 6.2 fix the Servant DSL ⏫
    - NOTE: After the changes to the core, the Servant examples won't work anymore
  - [ ] 6.5 try out idris-server http server project
    - [x] 6.5.1 run locally -- doesn't work ✅ 2021-11-10
    - [x] 6.5.2 Perform the suggested fixes from discord ✅ 2021-11-11
      - NOTE: didn't work, missing module: TyTTP.Support.Promise
    - [ ] 6.5.2' Perform the suggested fixes from discord
      - NOTE: Updated info from package author, need to try again!
    - [ ] 6.5.3 see if we can interpret LogIO into the node JS server
  - [ ] 6.7 Try out new lenses
    - [ ] 6.7.1 try the dependent van-laarhoven
      - `Functor f => ((i : a) -> {0 b : a -> Type} -> f (b i)) -> (i : s) -> {0 t : s -> Type} -> f (t i)`
  - [ ] 6.8 dependent lenses are morphisms between containers. Comonads are morphisms between
    directed containers. Can we convert from one to the other?
    - [ ] 6.8.1 Implement directed containers
    - [ ] 6.8.2 Directed containers morphisms as directed containers?
    - [ ] 6.8.3 dependent lenses as directed containers?
    - [ ] 6.8.4 directed containers as comonads
  - [ ] 6.9 Refactor the `PathComp` Datatype do get rid of `Str` constructor and use product and sum
    and `String.Singleton` instead
    - [ ] 6.9.1 remove the use of `Product` and `Sum` and replace it with a custom type with suitable
      parsing functions
  - [ ] 6.11 Take a look at Matteo's draft of the paper
  - [ ] 6.12 Allow dependent endpoints
  - [ ] 6.13 Tensor in the DSL ⏫
    - [ ] 6.13.1 Finish writing the tensor examples
    - [ ] 6.13.2 Port indexed interfaces to container interfaces

