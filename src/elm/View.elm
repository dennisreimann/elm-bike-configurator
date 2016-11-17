module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, src, target)
import Model exposing (Model)
import Update exposing (Msg)
import Panel exposing (panel)
import Canvas exposing (canvasLayers)


pageHeader : Html Msg
pageHeader =
    header
        [ class "header" ]
        [ h1
            [ class "header__title" ]
            [ text "Elm Bike Configurator" ]
        ]


pageFooter : Html Msg
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


view : Model -> Html Msg
view model =
    let
        panels =
            List.map panel model.components

        canvasBackground =
            img
                [ class "canvas__background"
                , src "/images/bg.png"
                ]
                []

        canvas =
            canvasBackground :: (List.map canvasLayers model.components)
    in
        div
            [ class "main" ]
            [ pageHeader
            , section
                [ class "configurator" ]
                [ div [ class "panels" ] panels
                , div [ class "canvas" ] canvas
                ]
            , pageFooter
            ]
