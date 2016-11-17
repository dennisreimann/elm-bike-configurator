module Types exposing (..)


type alias Model =
    { components : List Component }


type alias Component =
    { id : String
    , name : String
    , choices : List ComponentChoice
    , selection : Maybe ComponentChoice
    }


type alias ComponentChoice =
    { id : String
    , price : Int
    }


type Msg
    = NoOp
    | Select String ComponentChoice


newComponentChoice : String -> Int -> ComponentChoice
newComponentChoice id price =
    { id = id
    , price = price
    }


newComponent : String -> String -> List ComponentChoice -> Component
newComponent id name choices =
    { id = id
    , name = name
    , choices = choices
    , selection = List.head choices
    }
