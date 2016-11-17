module ComponentChoice exposing (..)


type alias ComponentChoice =
    { id : String
    , price : Int
    }


newComponentChoice : String -> Int -> ComponentChoice
newComponentChoice id price =
    { id = id
    , price = price
    }
