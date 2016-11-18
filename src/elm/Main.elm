module Main exposing (..)

import Html
import Types exposing (Model, Msg)
import State exposing (init, update, subscriptions)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
