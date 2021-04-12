module Examples.Functions exposing (..)

-- FUNCTIONS AS FIRST CLASS CITIZENS
-- In functional programming functions are first class citizens
-- This means that functions are treated as any other datatype, and can be stored in variables, passed as arguments, returned from functions and stored in datastructures

-- argument
function = \a b -> a + b

-- list of functions
var flist = [(\a -> a *2), (\a -> a - 2), (\a -> a + 100)]


-- HIGHER ORDER FUNCTIONS
-- Higher order functions is a sub-concept within functions as first class citizens
-- It means that functions can be passed as arguments, as well as returned from functions
-- an example being a map function, which takes a function and runs it on each element in a functor, before retuning the new functor

addFiveToEachElement : List number -> List number
addFiveToEachElement list =
    List.map (function 5) list

-- another example could be this function, which takes a function that takes something of a given type and returns something of the same type, as well as another paramter of that type
-- It then runs the function on that parameter twice, and returns the result

applyTwice : (a -> a) -> a -> a
applytwice f x =
    f (f x)

-- LAMBDAS
-- Lambdas are a way to create annonymous functions, when we only need them once.
-- An example would be when using the map function. If we need to do something very specific, that we'll never do again
-- we can just use a lambda function, like so

doSomethingComplicatedToEachElement : List number -> List number
doSomethingComplicatedToEachElement list =
    List.map (\a -> ((20 * a + 10) * 256)) list

-- Lambdas work because functions are a value just like 5 and "Hello, World" is. This is a consequence of functions being first class citizens