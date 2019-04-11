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
            if line == 0 then
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

                    n =
                        case List.head list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    h =
                        case List.head <| List.drop 1 list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    m =
                        case List.head <| List.drop 2 list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    t =
                        case List.head <| List.drop 3 list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    time =
                        (n - 1) * t + h * 60 + m
                in
                ( { model | line = line + 1 }, cout <| String.fromInt (modBy 24 (time // 60)) ++ "\n" ++ String.fromInt (modBy 60 time) )

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
