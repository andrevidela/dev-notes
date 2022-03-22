
# 6 Open-Servers
  - [ ] 6.2 fix the Servant DSL ⏫
    - NOTE: After the changes to the core, the Servant examples won't work anymore
    - issue #34
  - [x] 6.5 try out idris-server http server project ✅ 2022-03-14
    - [x] 6.5.1 run locally -- doesn't work ✅ 2021-11-10
    - [x] 6.5.2 Perform the suggested fixes from discord ✅ 2021-11-11
      - NOTE: didn't work, missing module: TyTTP.Support.Promise
    - [x] 6.5.2' Perform the suggested fixes from discord ✅ 2022-03-14
      - NOTE: Updated info from package author, need to try again!
    - [x] 6.5.3 see if we can interpret LogIO into the node JS server ✅ 2022-03-14
    - looks like this is not what we are looking for, the Tyttp library is too high level and the prototype diverged too much from Recombine
  - [-] ~~6.7 Try out new lenses~~
    - [-] ~~6.7.1 try the dependent van-laarhoven~~
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
  - [x] 6.11 Take a look at Matteo's draft of the paper ✅ 2022-02-17
  - [x] 6.12 Allow dependent endpoints ⏫ ✅ 2022-03-14
	  - We do not need this anymore
  - [x] 6.13 Tensor in the DSL ⏫ ✅ 2022-02-17
    - [x] 6.13.1 Finish writing the tensor examples ✅ 2022-02-17
  - [x] 6.14 Port indexed interfaces to container interfaces ✅ 2022-03-14
	  - Not going to work, it messes up inference
  - [ ] 6.15 implement state as directed container
	  - issue #44
  - [ ] 6.16 implement servers as bidirectional lenses for each endpoints
	  - issue #42
  - [ ] 6.17 finish database example
  - [ ] 6.18 add error management with co-parameter

