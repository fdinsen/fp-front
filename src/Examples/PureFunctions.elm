module Examples.PureFunctions exposing (..)

-- Pure functions are a concept that equalises mathematical functions with programmatical functions
-- In math, the values on each side of the equals sign are exactly equal. On top of that, the return value for identical paramters are always the same. This has a few consequences:
-- 1. The value of the parameters cannot be changed. If the parameter is a list, the list cannot be changed inside the function. In fact, in functional programming all datatypes are immutable
-- 2. There can be no side effects. This means that the function cannot do anything outside it's scope. It cannot update a database, it cannot change a website. Every effect a function has must be in form of a return value.
-- 3. There can be no outside influence. A function cannot look at something outside itself and its paramters which changes the result

-- Side effects should be avoided whenever possible, since they introduce unnecessary complexity and debugging. Pure functions are also really well suited for unit-testing, as they will always return the same value for the same parameter
-- In some cases, however, a Side effect is necessary. Whenever you need to do something outside the program, like updating a database, or changing a website, some side effects are needed.

-- Functional Programming compilers can be optimized a lot, because since all functions are predictable, you can cache the results of the functions. So if a function is called with the same parameter, we can just get the cached result
-- On top of this, parallelism is super easy, since all functions are independent of state, and cannot change shared data.