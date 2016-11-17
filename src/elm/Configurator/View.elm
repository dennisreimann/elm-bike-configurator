module Configurator.View exposing (view)

import Types exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList, src)


view : Model -> Html Msg
view model =
    let
        panels =
            List.map panel model.components

        canvasBackground =
            img
                [ class "canvas__background"
                , src "images/bg.png"
                ]
                []

        canvas =
            canvasBackground :: (List.map canvasLayers model.components)
    in
        section
            [ class "configurator" ]
            [ div [ class "panels" ] panels
            , div [ class "canvas" ] canvas
            ]



-- SUBVIEWS (private)


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
            , onClick (Select componentId choice)
            ]
            []
        ]
