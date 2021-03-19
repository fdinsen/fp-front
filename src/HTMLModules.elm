module HTMLModules exposing (..)

import Html exposing (..)
import Types exposing (Book, BookChange(..), Message(..), Model, Msg, User)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid exposing (Column)
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block

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