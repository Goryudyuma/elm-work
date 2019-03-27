port module Worker exposing (main)

{-| Example code for Qiita article
-}

import Platform


type alias Model =
    { line : Int
    , n : Int
    }


type Msg
    = Input Int String


init : ( Model, Cmd Msg )
init =
    ( { line = 0, n = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ n } as model) =
    case msg of
        Input line message ->
            if line == 0 then
                ( { model | line = line + 1 }, cout "Yes" )

            else
                ( { model | line = line + 1 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    cin <| Input model.line


port cout : String -> Cmd msg


port cin : (String -> msg) -> Sub msg


main : Platform.Program () Model Msg
main =
    Platform.worker
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
