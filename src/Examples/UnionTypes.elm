module Examples.UnionTypes exposing (..)

-- In Elm we're able to do something close to Polymorphism using what we call Union Types.
-- They are a type that can be one of a list of different types
-- When we want to use the type, we have to describe how we'll handle it, for each possible sub-type


import Http
type OnlineStatus
    = Online
    | Offline
    | Away Float
    | DoNotDisturb

type alias User =
    { onlineStatus : OnlineStatus
    , name : String
    }

getUserString : User -> String
getUserString user =
    case user.onlineStatus of
        Online ->
            "User " ++ user.name ++ " is currently online."
        Offline ->
            "User " ++ user.name ++ " is currently not online."
        Away time ->
            "User " ++ user.name ++ " has been away for " ++ (String.fromFloat time) ++ " seconds."
        DoNotDisturb ->
            "User " ++ user.name ++ " does not want to be disturbed."

-- In functional programming we don't have the value of Null
-- Instead, every time we have a situation where a value can be unset, we use the Union Type called Maybe
-- A maybe looks like this

type Maybe a
    = Nothing
    | Just a

-- Then we have to destructure the Maybe when we use it, using Pattern Matching. This avoids any and all Null Pointer errors

-- We can also use Union Types to handle errors.
-- The following example is one of the sub-models from my Elm Frontend, with some small changes
-- The Model has a Type for displaying the form, loading the response, displaying the success and also handling failure.
-- This way we always have a reaction defined for what happens when an error occurs.
-- We can even use the parameter to get even finer control over how each type of Http error is handled

type AddModel
    = AddForm Book User
    | AddLoading Book User
    | AddSuccess String
    | AddFailure Http.Error

type alias Book =
        {title : String
        ,author : String
        }