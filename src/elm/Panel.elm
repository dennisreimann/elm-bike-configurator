module Panel exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList)
import Component exposing (Component)
import ComponentChoice exposing (ComponentChoice)
import Update exposing (Msg)


panel : Component -> Html Msg
panel component =
    div
        [ class "panel" ]
        [ h3 [ class "panel__title" ] [ text component.name ]
        , panelItems component
        ]


panelItems : Component -> Html Msg
panelItems component =
    let
        selectionId =
            case component.selection of
                Just componentChoice ->
                    componentChoice.id

                Nothing ->
                    ""

        items =
            List.map (panelItem component.id selectionId) component.choices
    in
        ul [ class "panel__items" ] items


panelItem : String -> String -> ComponentChoice -> Html Msg
panelItem componentId selectionId choice =
    li
        [ classList
            [ ( "panel__item", True )
            , ( "panel__item--selected", choice.id == selectionId )
            ]
        ]
        [ button
            [ class ("panel__item__button panel__item__button--" ++ choice.id)
            , onClick (Update.Select componentId choice)
            ]
            []
        ]
