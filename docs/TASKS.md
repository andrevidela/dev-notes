# The todo items I'm working on publicly

The mailbox contains unrelated items which needs doing
Projects are marked with a title and a number. Sub-tasks
inherit the number of the project they belong to.

# Mailbox :

- [ ] install LSP

# Projects :

## 3 Myrmidon language
  - [ ] 3.1 finish the parser
  - [ ] 3.2 add Nat
  - [ ] 3.3 Add Vect
  - [ ] 3.4 Write tests
  - [ ] 3.5 Add grades

## 5 OpenGames things
  - [x] 5.1 use mwc-prob to port to singletons
      NOTE: it didn't work because singletons cannot promote constrained constructors
  - [x] 5.2 use mwc-prob to port to Idris
      NOTE: didn't work either
  - [ ] 5.3 write an idris version
      - [x] 5.3.1 port the core opengames logic with lenses
      - [x] 5.3.2 port the parser
      - [x] 5.3.3 port the compiler
      - [x] 5.3.4 port the code generator -- stuck on patterns
      - [ ] 5.3.5 figure out why evaluator doesn't reduce
      - [ ] 5.3.6 Implement type inference
        NOTE: types of the block are the boundary of the lens,
              the states are the products of the state of the lines
  - [ ]  5.4 Port the preprocessor to the updated version
  - [ ]  5.5 Write installation instructions for the haskell version
  - [ ]  5.6 Write the usage tutorial for use in Papillion

## 6 Open-Servers
  - [x] 6.1 port the core logic to indexed paths
  - [ ] 6.2 fix the examples
  - [ ] 6.3 change type of GET request to implement lenses instead of functions to lenses
        NOTE: Paths assume GET requests only take unit argument, this breaks the dependent
              lenses type signatures.
  - [ ] 6.4 implement the dep-lens EDSL
        NOTES: Almost done, just need to figure out the correct indices and test it, depends on 6.3
  - [ ] 6.5 try out idris-server http server project
      - [x] 6.5.1 run locally -- doesn't work (10.11.2021)
      - [x] 6.5.2 Perform the suggested fixes from discord (11.11.2021)
        NOTE: didn't work, missing module: TyTTP.Support.Promise
      - [ ] 6.5.2' Perform the suggested fixes from discord
        NOTE: Updated info from package author, need to try again!
      - [ ] 6.5.3 see if we can interpret LogIO into the node JS server

# 7 Data generic programming
  - [x] 7.1 implement in terms of CFTprogramming (10.11.2021)
  - [x] 7.2 implement in terms of typedefs (10.11.2021)
        NOTE: didn't work because typedefs are broken
  - [ ] 7.3 write the blog post about CFT
  - [x] 7.5 write the blog post about SplitN (10.11.2021)
  - [ ] 7.6 write blog post about Zippers

# 8 Idris proefficiency tutorial
  - [ ] 8.1 collect funtions from last AOC
  - [ ] 8.2 store helper functions in a library
    - [ ] 8.2.1 write documentation for functions
  - [ ] 8.3 write about data types
  - [ ] 8.4 write about IO
  - [ ] 8.5 write about common functions
  - [ ] 8.6 write about syntax

# Done:
- [x] fix the injection PR (10.11.2021)
- [x] fix the parser PR (10.11.2021)
- ## [1] install Scala 3
  - [x] 1.1 implement STLC with Match types ??? -- didn't work
- ## [2] figure out a DSL for programs
  - [x] 2.5 Check the injectivity pull request
  - [x] 2.6 Finish the dev notes about Idris2
  - [x] 2.7 Write the documentation for string interpolation concat
