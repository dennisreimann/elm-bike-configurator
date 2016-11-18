module Configurator.Data exposing (loadComponents)

import Http
import Types exposing (..)
import Json.Decode exposing (..)


loadComponents : Cmd Msg
loadComponents =
    Http.send ComponentsFetched (Http.get "components.json" componentsDecoder)


componentsDecoder : Decoder (List Component)
componentsDecoder =
    list componentDecoder


componentDecoder : Decoder Component
componentDecoder =
    map3 Component
        (field "id" string)
        (field "name" string)
        (field "choices" choicesDecoder)


choicesDecoder : Decoder (List ComponentChoice)
choicesDecoder =
    list choiceDecoder


choiceDecoder : Decoder ComponentChoice
choiceDecoder =
    map2 ComponentChoice
        (field "id" string)
        (field "price" int)
