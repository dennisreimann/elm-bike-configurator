module Main (..) where

import Html exposing (Html)
import Signal exposing (Signal)
import StartApp.Simple as StartApp
import Model
import Update
import View


main : Signal Html
main =
    StartApp.start
        { model = Model.initialModel
        , view = View.view
        , update = Update.update
        }
