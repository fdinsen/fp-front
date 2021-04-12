module Examples.PatternMatching exposing (..)

-- We can use pattern matching to split a datastructure up
-- This can be done if you want a single element from a list, convert the structure to a string, or the like

-- LIST
-- Here we take a list, and convert it to a String
-- We first check if the list is empty, if it is we return an empty string
-- Then we check if the list has a head (first element) and a tail (list of the rest of the elements)
-- which we use by returning a string containing the head and a recursive call on the rest of the list
listToString : List String -> String
listToString list =
    case list of
        [] -> ""
        head :: tail -> head ++ ", " ++ listToString tail


-- The following is an example of a getter function
-- We take a list, and a title and maybe return a book
-- If the list is empty, we know the book is not there, so we return nothing
-- if the list has a head and a tail, we check if the head has the right title, if it does we return it
-- if now, we call the same function recursively on the tail
type alias Book =
        {title : String
        ,author : String
        }

getBookByTitle : List Book -> String -> Maybe Book
getBookByTitle list title=
    case list of
        [] -> Nothing
        head :: tail ->
            if head.title == title then
                Just head
             else
                getBookByTitle tail title

-- RECORDS
-- Records can be descructured as early as in the parameters of a function
type alias Vector = (Float, Float)

type alias NamedPoint =
    { name : String
    , point : Vector
    }

namedPointToString : NamedPoint -> String
namedPointToString {name, point} =
    "Point " ++ name ++ " is located at (" ++ String.fromFloat (Tuple.first point) ++ "," ++ String.fromFloat (Tuple.second point) ++ ")"

-- Tuple
-- A tuple can be descructured the same way
vectorToString : Vector -> String
vectorToString (x, y) =
    "(" ++ String.fromFloat x ++ "," ++ String.fromFloat y ++ ")"


-- Union Types were explained in the Union Types hand-in