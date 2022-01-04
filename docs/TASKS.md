# The todo items I'm working on publicly

The mailbox contains unrelated items which needs doing
Projects are marked with a title and a number. Sub-tasks
inherit the number of the project they belong to.

# Mailbox :

  - [ ] Write abstract for Dependent types talk in March
  - [ ] Reproduce bug about namespaces and non-total functions at typechecking
    - NOTE: If you implement a function `f` inside a module `NS` and you create
      an additional namespace `NS` inside your module and have another function `f`
      inside it. Then implementing the nested `f` (`NS.NS.f`) as `f = NS.f` won't
      refer to the `f` at the top level module, but will refer to itself.
      This is obviously not total, and if you call `NS.NS.f` then it will loop
      forever. If `NS.NS.f` happens to occur at compile-time, the typechecker will
      hang forever.
  - [ ] Use idris-hedgehog to generate functions for equilibrium checking
    - NOTE: The goal is to, given a pair of types, generate all functions from
      one type to the other. `(a, b : Type) -> Stream (a -> b)`

# Projects :

## 3 Myrmidon language
  - [x] 3.1 finish the parser (15.11.2021)
  - [x] 3.2 add Nat (14.11.2021)
  - [ ] 3.3 Add Vect
  - [ ] 3.4 Add Fins
    - NOTE: Important for indexing vectors
  - [ ] 3.5 Add Bools
    - NOTE: Important for if-then-else
  - [ ] 3.6 Write tests
    - [x] 3.6.1 Write parser tests (15.11.2021)
    - [ ] 3.6.1 Write compiler tests
  - [x] 3.7 Add grades (14.12.2021)
    - [x] 3.7.1 fix typechecker (16.11.2021)
    - [x] 3.7.2 fix subst  (17.11.2021)
    - [x] 3.7.3 fix Quoting  (17.11.2021)
    - [x] 3.7.4 Abstract over the grades in context (14.12.2021)
      - NOTE: this was already done but I just noticed today (14.12.2021)
  - [ ] /!\ 3.6 compile surface syntax into AST
  - [ ] 3.7 Experiment with compiler passes
      - NOTE: Attempt to run linearity checking twice in a row to simulate a biaised semiring
        by partially evaluating things that are True and then typechecking again to see that none of the
        erased quantities remain.
  - [ ] 3.8 Add the funky semiring for both uses and stages
    - [x] 3.8.1 write definition (07.12.2021)
    - [ ] 3.8.3 prove that it's actually a semiring
  - [x] 3.9 Add a Scheme codegen (04.01.2022)

## 5 OpenGames things
  - [x] 5.1 use mwc-prob to port to singletons
      - NOTE: it didn't work because singletons cannot promote constrained constructors
      - NOTE: Maybe worth porting the probability library without mwc-prob
  - [x] 5.2 use mwc-prob to port to Idris
      - NOTE: didn't work either
      - NOTE: (09.12.2021) I don't remember what this is
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
  - [x] 5.4 Port the preprocessor to the updated version (13.12.2021)
  - [ ] 5.5 Write installation instructions for the haskell version
  - [ ] 5.6 Test the parser in the refactored version
  - [ ] 5.7 Open games implementation paper
    - [ ] 5.7.1 Draft chapters
    - [ ] 5.7.2 Write about scope checking

## 6 Open-Servers
  - [x] 6.1 port the core logic to indexed paths
  - [ ] 6.2 fix the examples
    - NOTE: After the changes to the core, the Servant examples won't work anymore
    - DEPENDS: 6.6
  - [x] 6.3 change type of GET request to implement lenses instead of functions to lenses (07.12.2021 - in reality done much earlier but I forgot to track the change)
  - [x] 6.4 implement the dep-lens EDSL (07.12.2021)
    - NOTES: kind of works but is blocked by 6.6
  - [ ] 6.5 try out idris-server http server project
    - [x] 6.5.1 run locally -- doesn't work (10.11.2021)
    - [x] 6.5.2 Perform the suggested fixes from discord (11.11.2021)
      - NOTE: didn't work, missing module: TyTTP.Support.Promise
    - [ ] 6.5.2' Perform the suggested fixes from discord
      - NOTE: Updated info from package author, need to try again!
    - [ ] 6.5.3 see if we can interpret LogIO into the node JS server
  - [ ] 6.6 Implement servers as Dependent Para lenses
    - [x] 6.6.1 implement server as a dependent lens rather than rely on the DSL (18.12.2021)
    - [x] 6.6.2 Implement routing as products of extended lenses rather than rely on `Str` path components (21.01.2022)
    - [x] 6.6.3 Fix an issue where the state could not be update because it depends on the input type of the request (01.01.2022)
    - [x] 6.6.4 Fix issue with dependent lenses where `composition` would not terminate (03.01.2022)
    - [ ] 6.6.5 Implement the missing dependent interfaces dependening on `server`, aka implement `instanceLens`
    - [ ] 6.6.6 reimplement server as external choice of existing servers
    - [ ] 6.6.7 (remove reliance on explicit instanciation of interfaces) (might be superseeded by 6.6.8)
    - [ ] 6.6.8 Rewrite a DSL for dependent para lens and give it a `ServerInstance` implementation

# 7 Data generic programming
  - [x] 7.1 implement in terms of CFTprogramming (10.11.2021)
  - [x] 7.2 implement in terms of typedefs (10.11.2021)
    - NOTE: didn't work because typedefs are broken
  - [ ] 7.3 write the blog post about CFT
  - [x] 7.5 write the blog post about SplitN (10.11.2021)
  - [ ] 7.6 write blog post about Zippers

# 8 Idris proefficiency tutorial
  - [x] 8.1 collect funtions from last AOC (14.11.2021)
  - [x] 8.2 store helper functions in a library (23.11.2021)
    - [x] 8.2.1 queues and zippers (16.11.2021)
    - [x] 8.2.2 n-dimensional spaces (23.11.2021)
    - [x] 8.2.3 binary manipulation (23.11.2021)
    - [x] 8.2.4 Cryptography (23.11.2021)
  - [ ] 8.3 write about data types
  - [ ] 8.4 write about IO
  - [ ] 8.5 write about common functions
  - [ ] 8.6 write about syntax
  - [ ] 8.7 write instructions to install and use
  - [x] 8.8 port the new functions to prolude and refactor AOC 2021 (07.12.2021)
    - [x] 8.8.1 Day 1 (07.12.2021)
    - [x] 8.8.2 Day 2 (07.12.2021)
    - [x] 8.8.3 Day 3 (07.12.2021)
    - [x] 8.8.4 Day 4 (07.12.2021)
    - [x] 8.8.5 Day 5 (07.12.2021)
    - [x] 8.8.6 Day 6 (07.12.2021)
    - [x] 8.8.7 Day 7 (07.12.2021)
    - [ ] 8.8.8 Day 8
    - [ ] 8.8.9 Day 9
    - [ ] 8.8.10 Day 10
    - [ ] 8.8.11 Day 11
    - [ ] 8.8.12 Day 12

# 9 Graphics
  - [ ] 9.1 Draw logo for DJSON
  - [x] 9.2 Draw logo for myrmidon
  - [ ] 9.3 Draw logo for Prolude
  - [ ] 9.4 update logo for Open servers
  - [ ] 9.5 Draw logo for AOC

# Done:
- [x] Fix prolude with latest Idris version (07.12.2021)
- [x] install LSP (05.12.2021)
- [x] fix the injection PR (10.11.2021)
- [x] fix the parser PR (10.11.2021)
- ## 1 install Scala 3
  - [x] 1.1 implement STLC with Match types ??? -- didn't work
- ## 2 figure out a DSL for programs
  - [x] 2.5 Check the injectivity pull request
  - [x] 2.6 Finish the dev notes about Idris2
  - [x] 2.7 Write the documentation for string interpolation concat
- [x] fix the PR about injection (23.11.2021)
