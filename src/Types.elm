module Types exposing (..)

import Http


type alias Model =
    (AddModel
    ,GetModel
    )

type Message
    -- GetModule related
    = GetBooks String
    | BooksResult (Result Http.Error User)
    | UsernameChanged String
    -- AddModule related
    | AddResult (Result Http.Error Msg)
    | BookChanged User Book BookChange String
    | AddUserChanged Book User String
    | PostBook Book User

type AddModel
    = AddForm Book User
    | AddLoading Book User
    | AddSuccess Msg
    | AddFailure Http.Error

type GetModel
    = GetForm String
    | GetLoading String
    | GetSuccess User
    | GetFailure Http.Error

type BookChange
    = TitleChange
    | AuthorChange

type alias User =
    {username : String
    ,books : List Book
    }

type alias Book =
    {title : String
    ,author : Author
    }

type alias Author =
    {name : String}

type alias Msg =
    {msg: String}


updateUsername : User -> String -> User
updateUsername user newName =
    {user | username = newName}

updateBook : Book -> BookChange -> String -> Book
updateBook book field new =
    let author = book.author in
    case field of
        TitleChange -> {book | title = new}
        AuthorChange -> {book | author = {author | name = new}}