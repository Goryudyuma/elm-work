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
                y =
                    String.filter (\c -> c == 'Y') message
                        |> String.length
                        |> String.fromInt

                e =
                    String.filter (\c -> c == 'E') message
                        |> String.length
                        |> String.fromInt

                a =
                    String.filter (\c -> c == 'A') message
                        |> String.length
                        |> String.fromInt

                h =
                    String.filter (\c -> c == 'H') message
                        |> String.length
                        |> String.fromInt

                exclamationMark =
                    String.filter (\c -> c == '!') message
                        |> String.length
                        |> String.fromInt
            in
            ( { model | line = line + 1 }, cout <| y ++ " " ++ e ++ " " ++ a ++ " " ++ h ++ " " ++ exclamationMark )


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
