module View exposing (view)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Configurator.View


view : Model -> Html Msg
view model =
    let
        configurator =
            Configurator.View.view model
    in
        div
            [ class "main" ]
            [ pageHeader
            , configurator
            , pageFooter
            ]



-- LAYOUT (private)


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
                [ href "https://github.com/dennisreimann/elm-bike-configurator" ]
                [ text "Source code on GitHub" ]
            ]
        , span
            [ class "footer__attribution" ]
            [ a
                [ href "https://flic.kr/p/cSHs3q" ]
                [ text "Original photo courtesy of Carey Ciuro" ]
            ]
        ]
