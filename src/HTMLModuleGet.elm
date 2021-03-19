module HTMLModuleGet exposing (..)

import ApiFacade exposing (errorToString)
import Bootstrap.Spinner as Spinner
import Bootstrap.Text as Text
import HTMLModules exposing (card)
import Html exposing (..)
import Html.Attributes exposing (style)
import Http
import Types exposing (Book, BookChange(..), Message(..), Model, Msg, User)
import Bootstrap.Grid exposing (Column)
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Table as Table exposing (Row)


getBooks : String -> Column Message
getBooks username =
    card
        "Get Books By User"
        [getBooksForm username
        ]

showBooks : String -> User -> Column Message
showBooks username user =
    card
        "Get Books By User"
        [getBooksForm username
        ,Table.simpleTable (Table.simpleThead
            [Table.th [] [text "Title"]
            ,Table.th [] [text "Author"]
            ]
            -- temp test value
            --,Table.tbody [] (List.map showBook [(Book "Book1" (Types.Author "Name")),(Book "Book1" (Types.Author "Name"))]) )
            ,Table.tbody [] (List.map showBook user.books) )
        ]

showBook : Book -> Row msg
showBook book =
    Table.tr [Table.rowInfo]
        [Table.td [] [text book.title]
        ,Table.td [] [text book.author.name]
        ]

getBooksForm : String -> Html Message
getBooksForm username =
        Form.form []
                     [Form.group []
                        [Form.label [] [text ("Username\n")]
                        ,Input.text [Input.value username, Input.onInput <| UsernameChanged ]
                        ]
                     ,ButtonGroup.buttonGroup [ButtonGroup.attrs [style "text-align" "center"]]
                        [ButtonGroup.button [Button.primary, Button.onClick <| GetBooks username ] [text ("Get Books")]]
                     ]

loadingUser : String -> Column Message
loadingUser username =
    card
        "Get Books By User"
        [getBooksForm username
        ,Spinner.spinner
            [ Spinner.grow
            , Spinner.large
            , Spinner.color Text.secondary
            , Spinner.attrs []
            ]
            [ Spinner.srMessage "Loading..." ]
        ]

getError : Http.Error -> Column Message
getError error =
    card
        "Get Books By User"
        [getBooksForm ""
        ,text ("An error has occurred: " ++ errorToString error)
        ]