module State exposing (init, update, subscriptions)

import Dict exposing (Dict)
import Types exposing (..)
import Configurator.Data exposing (loadComponents)


initialModel : Model
initialModel =
    { components = []
    , selection = Dict.empty
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, loadComponents )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select componentId choice ->
            let
                selection_ =
                    Dict.insert componentId choice model.selection
            in
                ( { model | selection = selection_ }, Cmd.none )

        ComponentsFetched (Ok components) ->
            ( { model | components = components }, Cmd.none )

        ComponentsFetched (Err _) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
