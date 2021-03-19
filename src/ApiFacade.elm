module ApiFacade exposing (..)

import Http exposing (Error(..))
import Types exposing (AddModel(..), Book, Message(..))
import Decoder as Decoder
import Encoder as Encoder

getBooks : String -> Cmd Message
getBooks username = Http.get
    { url = "https://fdinsen.com/fp-back/api/book/booksbyuser/" ++ username
    , expect = Http.expectJson BooksResult Decoder.userDecoder
    }

postBook : Book -> String -> Cmd Message
postBook book username = Http.post
    { url = "https://fdinsen.com/fp-back/api/book/add/" ++ username
    , body = Http.jsonBody (Encoder.encodeBook book)
    , expect = Http.expectJson AddResult Decoder.msgDecoder
    }


errorToString : Http.Error -> String
errorToString error =
    case error of
        BadUrl url ->
            ("Error, bad url: "++ url)
        Timeout ->
            "Error, connection timed out"
        NetworkError ->
            "Network Error"
        BadStatus code ->
            ("Error "++ String.fromInt code)
        BadBody errMsg ->
            ("Something went wrong with the body: " ++ errMsg)