module Canvas (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Component exposing (Component)


canvasLayers : Component -> Html
canvasLayers component =
    case component.selection of
        Just componentChoice ->
            img
                [ class ("canvas__layer canvas__layer--" ++ component.id)
                , src ("/images/" ++ component.id ++ "/" ++ componentChoice.id ++ ".png")
                ]
                []

        Nothing ->
            div
                [ class ("canvas__layer canvas__layer--" ++ component.id) ]
                []
