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
                list =
                    String.split " " message
                        |> List.map String.toInt
                        |> List.map
                            (\maybeValue ->
                                case maybeValue of
                                    Just value ->
                                        value

                                    Nothing ->
                                        0
                            )

                a =
                    case list |> List.drop 0 |> List.head of
                        Just value ->
                            value

                        Nothing ->
                            0

                b =
                    case list |> List.drop 1 |> List.head of
                        Just value ->
                            value

                        Nothing ->
                            0

                c =
                    case list |> List.drop 2 |> List.head of
                        Just value ->
                            value

                        Nothing ->
                            0

                d =
                    case list |> List.drop 3 |> List.head of
                        Just value ->
                            value

                        Nothing ->
                            0

                ans =
                    a
                        |> min (b // c)
                        |> min (d // (c + 1))
            in
            ( { model | line = line + 1 }, cout <| String.fromInt ans )


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
