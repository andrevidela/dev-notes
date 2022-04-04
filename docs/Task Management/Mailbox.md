# Mailbox :
  - [ ] Use idris-hedgehog to generate functions for equilibrium checking
    - NOTE: The goal is to, given a pair of types, generate all functions from
      one type to the other. `(a, b : Type) -> Stream (a -> b)`
  - [x] /!\ Complete support for ipkg in sirdi ✅ 2022-03-07
    - [x] Support cloning git ✅ 2022-02-06
      - NOTE: we need to pull the repository into a temp directory checkout and then copy back into sources
    - [x] Support legacy instructions ✅ 2022-02-06
      - NOTE: We need to know where the ipkg file is, and then run the install script# Mailbox
- [x] split tasks into smaller files and use quick add to add items to them ✅ 2022-03-18
- [x] permutations `Fin n -> a` ✅ 2022-03-22
- [x] connect to the game controller ✅ 2022-03-21
- [ ] finish preparing talk to BCS
- [ ] permutations, make a type that track values that have been plucked out
- [ ] Setup the benchmark server
	- [x] Install OS ✅ 2022-03-28
	- [ ] setup SSH keys
	- [ ] setup Mosh
	- [ ] Install Idris + Chez
	- [ ] run some benchmarks