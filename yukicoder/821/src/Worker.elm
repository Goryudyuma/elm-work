port module Worker exposing (main)

{-| Example code for Qiita article
-}

import BigInt
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

                    x =
                        BigInt.fromInt a

                    y =
                        BigInt.fromInt b
                in
                ( { model | line = line + 1 }
                , cout <|
                    BigInt.toString <|
                        BigInt.add (BigInt.fromInt 1) <|
                            BigInt.div
                                (BigInt.mul y (BigInt.add x <| BigInt.add (BigInt.fromInt 1) <| BigInt.sub x y))
                            <|
                                BigInt.fromInt 2
                )

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
