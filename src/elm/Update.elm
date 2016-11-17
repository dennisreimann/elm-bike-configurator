module Update exposing (..)

import Model exposing (Model)
import ComponentChoice exposing (ComponentChoice)


type Msg
    = NoOp
    | Select String ComponentChoice


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
