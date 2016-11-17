module Main exposing (..)

import Html
import Types exposing (Model, Msg)
import State exposing (initialModel, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
