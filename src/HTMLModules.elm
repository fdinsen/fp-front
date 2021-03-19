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


notImplemented : Column Message
notImplemented =
    card
        "Not Implemented"
        [text ("not implemented")]