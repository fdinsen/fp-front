module HTMLModuleAdd exposing (..)

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

addBook : Book -> User -> Column Message
addBook book user =
    card
        "Add Books"
        [addBookForm book user
        ]

addBookForm : Book -> User -> Html Message
addBookForm book user =
    Form.form []
                [Form.group []
                    [Form.label [] [text ("Title \n")]
                    ,Input.text [Input.value book.title, Input.onInput <| BookChanged user book TitleChange ]
                    ]
                ,Form.group []
                    [Form.label [] [text ("\nAuthor \n" )]
                    ,Input.text [Input.value book.author.name , Input.onInput <| BookChanged user book AuthorChange ]
                    ]
                ,Form.group []
                    [Form.label [] [text ("\nUsername \n" )]
                    ,Input.text [Input.value user.username , Input.onInput <| AddUserChanged book user ]
                    ]
                ,ButtonGroup.buttonGroup [ButtonGroup.attrs [style "text-align" "center"]]
                    [ButtonGroup.button [Button.primary, Button.onClick <| PostBook book user] [text "Add Book to User"]
                    ]
                ]

loadingBook : Book -> User -> Column Message
loadingBook book user =
    card
        "Add Books"
        [addBookForm book user
        ,Spinner.spinner
             [ Spinner.grow
             , Spinner.large
             , Spinner.color Text.secondary
             , Spinner.attrs []
             ]
             [ Spinner.srMessage "Loading..." ]
        ]

addSuccess : Msg -> Column Message
addSuccess msg =
    card
        "Add Books"
        [addBookForm (Book "" (Types.Author "")) (User "" [])
        ,text (msg.msg)
        ]

addError : Http.Error -> Column Message
addError error =
    card
        "Add Books"
        [addBookForm (Book "" (Types.Author "")) (User "" [])
        , text ("An error has occurred " ++ errorToString error)
        ]