module View (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Model exposing (Model)
import Update exposing (Action)
import Panel
import Canvas


pageHeader : Html
pageHeader =
    header
        [ class "header" ]
        [ h1
            [ class "header__title" ]
            [ text "Elm Bike Configurator" ]
        ]


pageFooter : Html
pageFooter =
    footer
        [ class "footer" ]
        [ span
            [ class "footer__attribution" ]
            [ a
                [ href "https://github.com/dennisreimann/elm-bike-configurator"
                , target "_blank"
                ]
                [ text "Source code on GitHub" ]
            ]
        , span
            [ class "footer__attribution" ]
            [ a
                [ href "https://flic.kr/p/cSHs3q"
                , target "_blank"
                ]
                [ text "Original photo courtesy of Carey Ciuro" ]
            ]
        ]


view : Address Action -> Model -> Html
view address model =
    let
        panels = List.map (Panel.panel address) model.components

        canvasBackground =
            img
                [ class "canvas__background"
                , src "/images/bg.png"
                ]
                []

        canvasLayers =
            canvasBackground :: (List.map Canvas.canvasLayers model.components)
    in
        div
            [ class "main" ]
            [ pageHeader
            , section
                [ class "configurator" ]
                [ div [ class "panels" ] panels
                , div [ class "canvas" ] canvasLayers
                ]
            , pageFooter
            ]
