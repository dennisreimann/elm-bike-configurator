module Types exposing (..)

import Http
import Dict exposing (Dict)


type alias Model =
    { components : List Component
    , selection : Selection
    }


type alias Selection =
    Dict String ComponentChoice


type alias ComponentId =
    String


type alias Component =
    { id : ComponentId
    , name : String
    , choices : List ComponentChoice
    }


type alias ComponentChoice =
    { id : String
    , price : Int
    }


type Msg
    = ComponentsFetched (Result Http.Error (List Component))
    | Select ComponentId ComponentChoice
