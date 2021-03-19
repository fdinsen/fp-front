module Main exposing (..)

import ApiFacade
import Browser
import HTMLModuleAdd exposing (addBook, addError, addSuccess, loadingBook)
import HTMLModuleGet exposing (getBooks, getError, loadingUser, showBooks)
import Html exposing (..)
import Bootstrap.Grid exposing (Column)
import HTMLModules exposing (grid, notImplemented)
import Types exposing (..)

main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

init : () -> (Model, Cmd message)
init _ = ((AddForm (Book "" (Author "")) (User "" []), GetForm ""), Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update message model =
    case message of
        --GetModule related
        GetBooks username ->
            ((Tuple.first model, GetLoading username), ApiFacade.getBooks username)
        BooksResult res ->
            case res of
               Ok user ->
                    ((Tuple.first model, GetSuccess user), Cmd.none)
               Err error -> ((Tuple.first model, GetFailure error), Cmd.none)
        UsernameChanged username ->
            ((Tuple.first model, GetForm username),Cmd.none)
        --AddModule related
        BookChanged user book field new->
            ((AddForm (updateBook book field new) user, Tuple.second model), Cmd.none)
        AddUserChanged book user new ->
            ((AddForm book (updateUsername user new), Tuple.second model), Cmd.none)
        PostBook book user ->
            ((AddForm book user, Tuple.second model), ApiFacade.postBook book user.username)
        AddResult res ->
            case res of
                Ok msg ->
                    ((AddSuccess msg, Tuple.second model), Cmd.none)
                Err error -> ((AddFailure error, Tuple.second model), Cmd.none)
        {-_ ->
            ((AddForm, GetForm), Cmd.none)-}

view : Model -> Html Message
view model =
    grid (getAddModel (Tuple.first model)) (getGetModel (Tuple.second model))

getAddModel : AddModel -> Column Message
getAddModel model =
    case model of
        AddForm book user ->
            addBook book user
        AddLoading book user ->
            loadingBook book user
        AddSuccess msg ->
            addSuccess msg
        AddFailure err ->
            addError err

getGetModel : GetModel -> Column Message
getGetModel model =
    case model of
        GetForm username ->
            getBooks username
        GetLoading username ->
            loadingUser username
        GetSuccess user ->
            showBooks "" user
        GetFailure err ->
            getError err

subscriptions : Model -> Sub Message
subscriptions _ = Sub.none


{- old monster of a view function
view : Model -> Html Message
view model =
    case model of
        (AddForm book user, GetForm username2) ->
            grid (addBook book user) (getBooks username2)
        (AddLoading book user, GetForm username) ->
            grid (loadingBook book user) (getBooks username)
        (AddSuccess book, GetForm username) ->
            grid (addSuccess book) (getBooks username)
        (AddFailure err, GetForm username) ->
            grid (addError err) (getBooks username)
        (AddForm book user, GetLoading username2) ->
            grid (addBook book user) (loadingUser username2)
        (AddForm book user, GetSuccess user1) ->
            grid (addBook book user) (showBooks "" user1)
        (AddForm book user, GetFailure err) ->
            grid (addBook book user) (getError err)
        (AddLoading book user, GetLoading username) ->
            grid (loadingBook book user) (loadingUser username)
        (AddLoading book user, GetSuccess user2) ->
            grid (loadingBook book user) (showBooks "" user2)
        (AddLoading book user, GetFailure err) ->
            grid (loadingBook book user) (getError err)
        (AddSuccess book, GetLoading username) ->
            grid (addSuccess book) (loadingUser username)
        (AddSuccess book, GetSuccess user) ->
            grid (addSuccess book) (showBooks "" user)
        (AddSuccess book, GetFailure err) ->
            grid (addSuccess book) (getError err)
        (AddFailure err, GetLoading username) ->
            grid (addError err)  (loadingUser username)
        (AddFailure err, GetSuccess user) ->
            grid (addError err)  (showBooks "" user)
        (AddFailure err, GetFailure err2) ->
            grid (addError err)  (getError err2)
-}
