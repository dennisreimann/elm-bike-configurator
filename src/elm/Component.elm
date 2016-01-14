module Component (..) where

import ComponentChoice exposing (ComponentChoice)


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
