module Configurator.View exposing (view)

import Dict
import Types exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList, src)


view : Model -> Html Msg
view model =
    let
        panels =
            List.map (panel model.selection) model.components

        layers =
            List.map (layer model.selection) model.components

        background =
            img
                [ class "canvas__background"
                , src "images/bg.png"
                ]
                []

        canvas =
            background :: layers
    in
        section
            [ class "configurator" ]
            [ div [ class "panels" ] panels
            , div [ class "canvas" ] canvas
            ]



-- SUBVIEWS (private)


layer : Selection -> Component -> Html Msg
layer selection component =
    let
        id =
            component.id

        chosen =
            Dict.get id selection
    in
        case chosen of
            Just choice ->
                img
                    [ class ("canvas__layer canvas__layer--" ++ id)
                    , src ("images/" ++ id ++ "/" ++ choice.id ++ ".png")
                    ]
                    []

            Nothing ->
                div
                    [ class ("canvas__layer canvas__layer--" ++ id) ]
                    []


panel : Selection -> Component -> Html Msg
panel selection component =
    let
        id =
            component.id

        chosen =
            Dict.get id selection

        items =
            List.map (panelItem chosen component.id) component.choices
    in
        div
            [ class "panel" ]
            [ h3 [ class "panel__title" ] [ text component.name ]
            , ul [ class "panel__items" ] items
            ]


panelItem : Maybe ComponentChoice -> String -> ComponentChoice -> Html Msg
panelItem chosen componentId choiceOption =
    let
        selected =
            case chosen of
                Just componentChoice ->
                    choiceOption == componentChoice

                Nothing ->
                    False
    in
        li
            [ classList
                [ ( "panel__item", True )
                , ( "panel__item--selected", selected )
                ]
            ]
            [ button
                [ class ("panel__item__button panel__item__button--" ++ choiceOption.id)
                , onClick (Select componentId choiceOption)
                ]
                []
            ]
