module Panel (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Update
import Component exposing (Component)
import ComponentChoice exposing (ComponentChoice)


panel : Address Update.Action -> Component -> Html
panel address component =
    div
        [ class "panel" ]
        [ h3 [ class "panel__title" ] [ text component.name ]
        , panelItems address component
        ]


panelItems : Address Update.Action -> Component -> Html
panelItems address component =
    let
        selectionId =
            case component.selection of
                Just componentChoice ->
                    componentChoice.id

                Nothing ->
                    ""

        items =
            List.map (panelItem address component.id selectionId) component.choices
    in
        ul [ class "panel__items" ] items


panelItem : Address Update.Action -> String -> String -> ComponentChoice -> Html
panelItem address componentId selectionId choice =
    li
        [ classList
            [ ( "panel__item", True )
            , ( "panel__item--selected", choice.id == selectionId )
            ]
        ]
        [ button
            [ class ("panel__item__button panel__item__button--" ++ choice.id)
            , onClick address (Update.Select componentId choice)
            ]
            []
        ]
