# 3 Myrmidon language
  - [ ] 3.3 Add Vect
  - [ ] 3.4 Add Fins
    - NOTE: Important for indexing vectors
  - [ ] 3.5 Add Bools
    - NOTE: Important for if-then-else
  - [ ] 3.6 Write tests
    - [x] 3.6.1 Write parser tests (15.11.2021)
    - [ ] 3.6.2 /!\ Read files and execute them
    - [ ] 3.6.3 Read files and compile them
    - [ ] 3.6.4 figure out how to run a file from the haskell version
    - [ ] 3.6.5 Write compiler tests based on the haskell version
  - [ ] 3.7 Experiment with compiler passes
      - NOTE: Attempt to run linearity checking twice in a row to simulate a biaised semiring
        by partially evaluating things that are True and then typechecking again to see that none of the
        erased quantities remain.
  - [ ] 3.8 Add the funky semiring for both uses and stages
    - [x] 3.8.1 write definition (07.12.2021)
    - [ ] 3.8.3 prove that it's actually a semiring
  - [ ] 3.9 implement co-debruijn indices
  - [ ] 3.11 write a REPL
  - [ ] 3.12 attempt a affine type system using `0`, `0-1`, `1`, `1-ω` and `ω` where `0<ω` , `1 < 1-ω` and `0-1 < 1`
  - [ ] 3.13 add data types and case