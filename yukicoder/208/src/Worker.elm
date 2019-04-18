port module Worker exposing (main)

{-| Example code for Qiita article
-}

import Json.Decode
import Platform


type alias Model =
    { line : Int
    , a : Int
    , b : Int
    }


type Msg
    = Input Int String


init : ( Model, Cmd Msg )
init =
    ( { line = 0, a = 0, b = 0 }, Cmd.none )


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

                    a =
                        case List.head list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    b =
                        case List.head <| List.reverse list of
                            Just value ->
                                value

                            Nothing ->
                                0
                in
                ( { model | line = line + 1, a = a, b = b }, Cmd.none )

            else
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
                        case List.head list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    b =
                        case List.head <| List.reverse list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    ans =
                        if a == b && model.a == model.b && a < model.a then
                            model.a + 1

                        else
                            max model.a model.b
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
