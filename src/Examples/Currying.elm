module Examples.Currying exposing (..)


-- Whenever you create a function that takes multiple parameters, you're actually creating a function for each additional parameter past the first one
-- this means that a function that looks as follows, can also have it's function declaration look like multThree : number -> (number -> (number -> number))
-- if we were to give the function only one parameter, say 2, it would return a function that takes a parameter, multiplies it by 2 and returns another function
-- this function then takes a parameter which is multiplies by the result of the first function and then finally returns that number

-- Each of these functions have the function declarations:
-- number -> (number -> (number -> number))
-- number -> (number -> number)
-- number -> number

multThree : number -> number -> number -> number
multThree x y z =
    x * y * z


-- only giving a function some of it's neccesary parameters is called partial application, and is extremely powerful. See the following example
-- here we have a function that takes a function and applies it to the second parameter twice.

applyTwice : (a -> a) -> a -> a
applyTwice f x =
    f (f x)

-- if we pass it multhree, with only two paramters, like so

example : number
example = applyTwice (multThree 2 2) 9

-- it'll do the multThree calculation twice (2*2*2*2) and then multiply that by 9 giving 144


-- another time this is useful is when using the map function. There we'll pass it multThree with only two arguments
-- the final argument will be filled with each element in the list
exampleb : List number -> List number
exampleb list =
    List.map (multThree 2 5) list