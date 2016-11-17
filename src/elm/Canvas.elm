module Canvas exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Component exposing (Component)
import Update exposing (Msg)


canvasLayers : Component -> Html Msg
canvasLayers component =
    case component.selection of
        Just componentChoice ->
            img
                [ class ("canvas__layer canvas__layer--" ++ component.id)
                , src ("images/" ++ component.id ++ "/" ++ componentChoice.id ++ ".png")
                ]
                []

        Nothing ->
            div
                [ class ("canvas__layer canvas__layer--" ++ component.id) ]
                []
