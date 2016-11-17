module Main exposing (..)

import Html
import Model exposing (Model, initialModel)
import View exposing (view)
import Update exposing (Msg, update)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
