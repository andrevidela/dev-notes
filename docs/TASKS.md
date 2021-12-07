# The todo items I'm working on publicly

The mailbox contains unrelated items which needs doing
Projects are marked with a title and a number. Sub-tasks
inherit the number of the project they belong to.

# Mailbox :


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
  - [ ] 3.7 Add grades
    - [x] 3.7.1 fix typechecker (16.11.2021)
    - [x] 3.7.2 fix subst  (17.11.2021)
    - [x] 3.7.3 fix Quoting  (17.11.2021)
    - [ ] 3.7.4 Abstract over the grades in context
  - [ ] 3.6 compile surface syntax into AST
  - [ ] 3.7 Experiment with compiler passes
  - [ ] 3.8 Add the funky semiring for both uses and stages

## 5 OpenGames things
  - [x] 5.1 use mwc-prob to port to singletons
      - NOTE: it didn't work because singletons cannot promote constrained constructors
  - [x] 5.2 use mwc-prob to port to Idris
      - NOTE: didn't work either
  - [ ] 5.3 write an idris version
    - [x] 5.3.1 port the core opengames logic with lenses
    - [x] 5.3.2 port the parser
    - [x] 5.3.3 port the compiler
    - [x] 5.3.4 port the code generator -- stuck on patterns
    - [ ] 5.3.5 figure out why evaluator doesn't reduce
    - [ ] 5.3.6 Implement type inference
      - NOTE: types of the block are the boundary of the lens,
        the states are the products of the state of the lines
  - [ ]  5.4 Port the preprocessor to the updated version
  - [ ]  5.5 Write installation instructions for the haskell version

## 6 Open-Servers
  - [x] 6.1 port the core logic to indexed paths
  - [ ] 6.2 fix the examples
  - [x] 6.3 change type of GET request to implement lenses instead of functions to lenses (07.12.2021 - in reality done much earlier but I forgot to track the change)
  - [x] 6.4 implement the dep-lens EDSL (07.12.2021)
    - NOTES: kind of works but is blocked by 6.6
  - [ ] 6.5 try out idris-server http server project
    - [x] 6.5.1 run locally -- doesn't work (10.11.2021)
    - [x] 6.5.2 Perform the suggested fixes from discord (11.11.2021)
      NOTE: didn't work, missing module: TyTTP.Support.Promise
    - [ ] 6.5.2' Perform the suggested fixes from discord
      NOTE: Updated info from package author, need to try again!
    - [ ] 6.5.3 see if we can interpret LogIO into the node JS server
  - [ ] 6.6 Implement Free Dependent Para lenses
    - NOTE: Maybe it's possible to re-implement DepParaLenses in terms of FreeDepParaLens
    - NOTE: Maybe it's possible to write both depending on a given type algebra
    - NOTE: This is necessary in order to recover how each lens is composed with each other for the DSL
      Without it we can't implement `Extend` nor `Prefix`


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

# 9 Graphics
  - [ ] 9.1 Draw logo for DJSON
  - [x] 9.2 Draw logo for myrmidon
  - [ ] 9.3 Draw logo for Prolude
  - [ ] 9.4 update logo for Open servers
  - [ ] 9.5 Draw logo for AOC

# Done:
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
