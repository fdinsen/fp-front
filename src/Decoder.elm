module Decoder exposing (..)

import Json.Decode as Decode
import Types exposing (Author, Book, Msg, User)


userDecoder : Decode.Decoder User
userDecoder =
    Decode.map2 User
        (Decode.field "username" Decode.string)
        (Decode.field "books" (Decode.list bookDecoder))

bookDecoder : Decode.Decoder Book
bookDecoder =
    Decode.map2 Book
        (Decode.field "title" Decode.string)
        (Decode.field "author" authorDecoder)

authorDecoder : Decode.Decoder Author
authorDecoder =
    Decode.map Author
        (Decode.field "name" Decode.string)

msgDecoder : Decode.Decoder Msg
msgDecoder =
    Decode.map Msg
        (Decode.field "msg" Decode.string)