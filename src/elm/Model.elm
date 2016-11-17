module Model exposing (..)

import Component exposing (Component)
import AppData exposing (frame, tires, chain, saddle, grips)


type alias Model =
    { components : List Component }


initialModel : Model
initialModel =
    { components =
        [ frame
        , tires
        , chain
        , saddle
        , grips
        ]
    }
