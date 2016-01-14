module Update (..) where

import Model exposing (Model)
import Component exposing (Component)
import ComponentChoice exposing (ComponentChoice)


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
