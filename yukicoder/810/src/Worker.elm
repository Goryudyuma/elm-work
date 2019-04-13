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

                    l =
                        case List.head list of
                            Just value ->
                                value

                            Nothing ->
                                0

                    r =
                        case list |> List.drop 1 |> List.head of
                            Just value ->
                                value

                            Nothing ->
                                0

                    m =
                        case list |> List.drop 2 |> List.head of
                            Just value ->
                                value

                            Nothing ->
                                0
                in
                ( { model | line = line + 1 }, cout <| String.fromInt <| min (r - l + 1) m )

            else
                ( { model | line = line + 1 }, cout <| model.ans ++ " " ++ message )


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
