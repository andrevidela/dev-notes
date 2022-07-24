# Projects :

Here are the projects I'm currently working on

- [[Myrmidon]] A programming language leveraging QTT to control partial evaluation
- [[Open servers]] A Library to write web servers using lenses
- [[Open Games]] An programming language to write Open Games
- [[Idris Profficiency]] A short tutorial to get started with Idris
- [[Servers Lens tutorial]] A tutorial about open-servers as a library


---------------------------------------------------------------------------------

# Done:

## Mailbox
  - [-] Reproduce bug about namespaces and non-total functions at typechecking
      - NOTE: If you implement a function `f` inside a module `NS` and you create
        an additional namespace `NS` inside your module and have another function `f`
        inside it. Then implementing the nested `f` (`NS.NS.f`) as `f = NS.f` won't
        refer to the `f` at the top level module, but will refer to itself.
        This is obviously not total, and if you call `NS.NS.f` then it will loop
        forever. If `NS.NS.f` happens to occur at compile-time, the typechecker will
        hang forever.
      - NOTE: I gave up, it takes too much time and it's too finnicky.
  - [x] Fix prolude with latest Idris version ✅ 2021-12-07
  - [x] install LSP ✅ 2021-12-05
  - [x] fix the injection PR ✅ 2021-11-10
  - [x] fix the parser PR ✅ 2021-11-10
  - [x] 1 install Scala 3
    - [x] 1.1 implement STLC with Match types ??? -- didn't work
  - [x] 2 figure out a DSL for programs
    - [x] 2.5 Check the injectivity pull request
    - [x] 2.6 Finish the dev notes about Idris2
    - [x] 2.7 Write the documentation for string interpolation concat
  - [x] fix the PR about injection ✅ 2021-11-23
  - [x] move all NPL Org into gitlab
  - [x] Complete linear PR ✅ 2022-01-31
  - [x] Write abstract for Dependent types talk in March ✅ 2022-02-05



## 3 Myrmidon language
  - [x] 3.1 finish the parser (15.11.2021)
  - [x] 3.2 add Nat (14.11.2021)
  - [x] 3.6 compile surface syntax into AST
  - [x] 3.7 Add grades (14.12.2021)
    - [x] 3.7.1 fix typechecker (16.11.2021)
    - [x] 3.7.2 fix subst  (17.11.2021)
    - [x] 3.7.3 fix Quoting  (17.11.2021)
    - [x] 3.7.4 Abstract over the grades in context (14.12.2021)
      - NOTE: this was already done but I just noticed today ✅ 2021-12-14
  - [x] 3.9 Add a Scheme codegen ✅ 2022-01-04

## 5 OpenGames things
  - [x] 5.1 use mwc-prob to port to singletons
      - NOTE: it didn't work because singletons cannot promote constrained constructors
      - NOTE: Maybe worth porting the probability library without mwc-prob
  - [x] 5.2 use mwc-prob to port to Idris
      - NOTE: didn't work either
      - NOTE: (09.12.2021) I don't remember what this is
  - [x] 5.4 Port the preprocessor to the updated version (13.12.2021)
## 6 Open-Servers
  - [x] 6.1 port the core logic to indexed paths
  - [x] 6.3 change type of GET request to implement lenses instead of functions to lenses (07.12.2021 - in reality done much earlier but I forgot to track the change)
  - [x] 6.4 implement the dep-lens EDSL (07.12.2021)
    - NOTES: kind of works but is blocked by 6.6
  - [x] 6.6 Implement servers as Dependent Para lenses (09.01.2022)
    - [x] 6.6.1 implement server as a dependent lens rather than rely on the DSL (18.12.2021)
    - [x] 6.6.2 Implement routing as products of extended lenses rather than rely on `Str` path components (21.01.2022)
    - [x] 6.6.3 Fix an issue where the state could not be update because it depends on the input type of the request (01.01.2022)
    - [x] 6.6.4 Fix issue with dependent lenses where `composition` would not terminate (03.01.2022)
    - [x] 6.6.5 Implement the missing dependent interfaces dependening on `server`, aka implement `instanceLens` (05.01.2022)
    - [x] 6.6.6 reimplement server as external choice of existing servers (05.01.2022)
      - COMMIT: e5995e537c2990
    - [x] 6.6.7 Implement a server as external choice but with a top level path (05.01.2022)
      - NOTE: AKA
        ```
        /lights ╶┬╴/kitchen
                 └╴/bedroom
        ```
      - COMMIT: 7f1260385e
    - [x] 6.6.8 Rewrite a DSL for dependent para lens and give it a `ServerInstance` implementation ^5e3aef (06.01.2022)
      - NOTE: It's working but two things are strange:
        1. we need some sort of `Update` interface which ensures we can update the final state from some substate
        2. Our `State` constructor requires the overall state to be parsable but that is not necessary if we don't expose the
           `POST` part of the endpoint
    - [x] 6.6.9 Fix the MR review comments (09.01.2022)
  - [x] 6.10 Make it possible to have endpoints with arguments in the middle

# 7 Data generic programming
  - [x] 7.1 implement in terms of CFTprogramming (10.11.2021)
  - [x] 7.2 implement in terms of typedefs (10.11.2021)
    - NOTE: didn't work because typedefs are broken
  - [x] 7.5 write the blog post about SplitN (10.11.2021)

# 8 Idris proefficiency tutorial
  - [x] 8.1 collect funtions from last AOC (14.11.2021)
  - [x] 8.2 store helper functions in a library (23.11.2021)
    - [x] 8.2.1 queues and zippers (16.11.2021)
    - [x] 8.2.2 n-dimensional spaces (23.11.2021)
    - [x] 8.2.3 binary manipulation (23.11.2021)
    - [x] 8.2.4 Cryptography (23.11.2021)

# 9 Graphics
  - [x] 9.2 Draw logo for myrmidon

# 10 OPLSS

- [ ] Understand and write about W-types
- [ ] containers <-> Polynomial functors
	- [ ] Write n-ary functors
	- [ ] Link up fixpoints of containers with fixpoints of polynomial functors and recover cata from it
- [ ] Metamorphisms
	- [ ] Check if stream can use `List` instead of `Maybe` for non-deterministic buffers
	- [ ] Check if it can work on any `1 + n` functor so you can have non-determinism on trees
- [ ] Sequent calculus
	- [ ] Categorical semantics
	- [ ] implement SC in agda/Idris
	- [ ] product and co-products aren't symetric???
- [ ] Reading
	- [ ] Review Clowns to the left, jokers to the right
	- [ ] Review Fractional types from Dorchard
	- [ ] Review Composing Bidirectional programs monadically
- [ ] Implement Jeremy's paper about breath-first search tree-traversal
	- Could this be used for a more general version of traversing data structures without respecting their original definitions?
- [ ] Figure out the link between zippers and lenses
	- Any link with derivatives?
- [ ] Merge `oplss` `lenses` and `poly` from `Neko` into `TypesLab`
- [ ] Merge `oplss` and `state-machines` from algae into `TypesLab`
- [ ] 
