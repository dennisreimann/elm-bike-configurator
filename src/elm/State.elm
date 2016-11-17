module State exposing (initialModel, update)

import Types exposing (..)


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


update : Msg -> Model -> Model
update msg model =
    case msg of
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



-- VALUES (private)


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
