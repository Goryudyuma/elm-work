port module Worker exposing (main)

{-| Example code for Qiita article
-}

import Json.Decode
import Platform


type alias Model =
    { line : Int
    , ans : String
    }


type Msg
    = Input Int String


init : ( Model, Cmd Msg )
init =
    ( { line = 0, ans = "" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input line message ->
            let
                n =
                    String.toInt message
                        |> Maybe.withDefault 0

                ans =
                    3 :: List.repeat (n - 2) 1 ++ [ 312454 - 3 - (n - 2) * 1 ]

                ansStr =
                    ans
                        |> List.map String.fromInt
                        |> String.join " "
            in
            ( model, cout <| ansStr )


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
