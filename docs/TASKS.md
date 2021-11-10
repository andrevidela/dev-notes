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

## 6 Open-Servers
  - [x] 6.1 port the core logic to indexed paths
  - [ ] 6.2 fix the examples
  - [ ] 6.3 change type of GET request to implement lenses instead of functions to lenses
  - [ ] 6.4 implement the dep-lens EDSL
  - [ ] 6.5 try out idris-server http server project
      - [x] 6.5.1 run locally -- doesn't work (10.11.2021)
      - [ ] 6.5.2 see if we can interpret LogIO into the node JS server

# 7 Data generic programming
  - [x] 7.1 implement in terms of CFTprogramming (10.11.2021)
  - [x] 7.2 implement in terms of typedefs (10.11.2021)
        NOTE: didn't work because typedefs are broken
  - [ ] 7.3 write the blog post about CFT
  - [ ] 7.5 write the blog post about SplitN
  - [ ] 7.6 write blog post about Zippers

# Done:
- [x] fix the injection PR (10.11.2021)
- [x] fix the parser PR (10.11.2021)
- ## [1] install Scala 3
  - [x] 1.1 implement STLC with Match types ??? -- didn't work
- ## [2] figure out a DSL for programs 
  - [x] 2.5 Check the injectivity pull request 
  - [x] 2.6 Finish the dev notes about Idris2  
  - [x] 2.7 Write the documentation for string interpolation concat 
