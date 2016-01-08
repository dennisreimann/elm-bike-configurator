module Main where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import StartApp.Simple as StartApp


type alias Component =
    { id : String
    , name : String
    , choices : List ComponentChoice
    , selection : Maybe ComponentChoice
    }


newComponent : String -> String -> List ComponentChoice -> Component
newComponent id name choices =
    { id = id
    , name = name
    , choices = choices
    , selection = List.head choices
    }


type alias ComponentChoice =
    { id : String
    , price : Int
    }


newComponentChoice : String -> Int -> ComponentChoice
newComponentChoice id price =
    { id = id
    , price = price
    }


frame : Component
frame =
    newComponent
        "frame"
        "Frame"
        [ newComponentChoice "lightblue" 50
        , newComponentChoice "darkblue" 50
        , newComponentChoice "green" 45
        , newComponentChoice "pink" 50
        , newComponentChoice "white" 50
        , newComponentChoice "rainbow" 100
        ]


grips : Component
grips =
    newComponent
        "grips"
        "Grips"
        [ newComponentChoice "white" 10
        , newComponentChoice "yellow" 10
        , newComponentChoice "green" 10
        , newComponentChoice "pink" 10
        , newComponentChoice "brown" 10
        , newComponentChoice "black" 10
        ]


saddle : Component
saddle =
    newComponent
        "saddle"
        "Saddle"
        [ newComponentChoice "white" 15
        , newComponentChoice "yellow" 20
        , newComponentChoice "green" 20
        , newComponentChoice "pink" 20
        , newComponentChoice "brown" 15
        , newComponentChoice "black" 15
        ]


chain : Component
chain =
    newComponent
        "chain"
        "Chain"
        [ newComponentChoice "yellow" 30
        , newComponentChoice "green" 30
        , newComponentChoice "pink" 30
        , newComponentChoice "lightblue" 30
        , newComponentChoice "gray" 30
        ]


tires : Component
tires =
    newComponent
        "tires"
        "Tires"
        [ newComponentChoice "white" 80
        , newComponentChoice "black" 80
        ]


type alias Model =
    { components : List Component }


initialModel : Model
initialModel =
    { components =
        [ frame
        , tires
        , chain
        , saddle
        , grips
        ]
    }


type Action
    = NoOp
    | Select String ComponentChoice


update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            model

        Select componentId choice ->
            let
                updateComponent component =
                    if component.id == componentId then
                        { component | selection = Just choice }
                    else
                        component
            in
                { model | components = List.map updateComponent model.components }


canvasLayer : Component -> Html
canvasLayer component =
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


panel : Address Action -> Component -> Html
panel address component =
    div
        [ class "panel" ]
        [ h3 [ class "panel__title" ] [ text component.name ]
        , panelItems address component
        ]


panelItems : Address Action -> Component -> Html
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


panelItem : Address Action -> String -> String -> ComponentChoice -> Html
panelItem address componentId selectionId choice =
    li
        [ classList
            [ ( "panel__item", True )
            , ( "panel__item--selected", choice.id == selectionId )
            ]
        ]
        [ button
            [ class ("panel__item__button panel__item__button--" ++ choice.id)
            , onClick address (Select componentId choice)
            ]
            []
        ]


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
        panels = List.map (panel address) model.components

        canvasBackground =
            img
                [ class "canvas__background"
                , src "/images/bg.png"
                ]
                []

        canvasLayers =
            canvasBackground :: (List.map canvasLayer model.components)
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


main : Signal Html
main =
    StartApp.start
        { model = initialModel
        , view = view
        , update = update
        }
