module Encoder exposing (..)

import Json.Encode as Encode
import Types exposing (Author, Book, User)


encodeBook : Book -> Encode.Value
encodeBook book =
    Encode.object
        [("title", Encode.string book.title)
        ,("author", encodeAuthor book.author)
        ]

encodeAuthor : Author -> Encode.Value
encodeAuthor author =
    Encode.object
        [("name", Encode.string author.name)]

encodeUser : User -> Encode.Value
encodeUser user =
    Encode.object
        [("username", Encode.string user.username)]