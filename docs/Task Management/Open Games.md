# 5 OpenGames things
  - [ ] 5.3 write an idris version
    - [x] 5.3.1 port the core opengames logic with lenses (07.11.2021)
    - [x] 5.3.2 port the parser (08.11.2021)
    - [x] 5.3.3 port the compiler (09.11.2021)
    - [x] 5.3.4 port the code generator (11.11.2021)
    - [x] 5.3.5 figure out why evaluator doesn't reduce (09.12.2021)
      - NOTE: It works now! but it's really slow, and using the scheme evaluator fails,
        I don't know why yet but but it seems to be due to scheme, the generated scheme leads to an
        error when sent to the runtime, so the `eval` function returns an excepption. We catch it
        but we don't return its diagnostic info, so we need to change that to make it available.
    - [ ] 5.3.6 Implement type inference
      - NOTE: types of the block are the boundary of the lens, the states are the products of the state of the lines
    - [ ] 5.3.7 update the scheme support file to return either rather than Maybe
  - [ ] 5.5 Write installation instructions for the haskell version
  - [x] 5.6 Test the parser in the refactored version ⏫ ✅ 2022-03-18
     - [ ] 5.6.1 port the code from vlad
       NOTE:
       - change all the decision operators to use the ones from philips code (the kleisli stuff)
       - Stuck because of 5.9
  - [ ] 5.7 Open games implementation paper
    - [ ] 5.7.1 Draft chapters
    - [ ] 5.7.2 Write about scope checking
  - [x] 5.8 Move updated project into original repository ⏫ ✅ 2022-03-18
    - [x] 5.8.1 Tag Version 0.1 of Open games ✅ 2022-02-09
    - [x] 5.8.2 Adapt the directory structure and namespaces of Philipp's fork from old OG Master ✅ 2022-06-12
    - [x] 5.8.3 overwrite master with Philip's updated fork ✅ 2022-06-12
    - [ ] 5.8.4 rewrite Jules' version in terms of the new master
    - [x] 5.8.5 delete Jules version ✅ 2022-06-12

  - [x] 5.9 /!\ implement typed population without implementation ✅ 2022-02-03
  - [x] 5.10 implement AMM in terms of new types and deriving via ✅ 2022-04-22
    - [x] 5.10.1 implement testing from State to IO ✅ 2022-04-22
  - [ ] 5.11 move everything to GHC 9.2 on ARM
  - [ ] Import the given example into Open Games