module HTMLModules exposing (..)

import ApiFacade exposing (errorToString)
import Bootstrap.Spinner as Spinner
import Bootstrap.Text as Text
import Html exposing (..)
import Html.Attributes exposing (style)
import Http
import Types exposing (Book, BookChange(..), Message(..), Model, Msg, User)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid exposing (Column)
import Bootstrap.Grid.Col as Col
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Table as Table exposing (Row)

grid : Column Message -> Column Message -> Html Message
grid view1 view2  =
    Grid.container []
        [CDN.stylesheet
        ,Grid.row []
            [view1
            ,view2
            ]
        ]

card : String -> List (Html Message) -> Column Message
card header content =
    Grid.col [Col.lg6]
        [Card.config [Card.outlineInfo]
            |> Card.headerH1 [] [text header]
            |> Card.block []
                [Block.text []
                    content
                ]
            |> Card.view
        ]


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

notImplemented : Column Message
notImplemented =
    card
        "Not Implemented"
        [text ("not implemented")]