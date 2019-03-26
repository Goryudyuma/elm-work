port module Worker exposing (main)

{-| Example code for Qiita article
-}

import Json.Decode
import List.Extra as List
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
                hour =
                    String.split ":" message
                        |> List.head
                        |> Maybe.andThen String.toInt
                        |> Maybe.withDefault 0

                minute =
                    String.split ":" message
                        |> List.reverse
                        |> List.head
                        |> Maybe.andThen String.toInt
                        |> Maybe.withDefault 0

                sum =
                    hour * 60 + minute * 1 + 5

                anshour =
                    modBy 24 <| sum // 60

                ansminute =
                    modBy 60 <| sum

                format num =
                    num
                        |> String.fromInt
                        |> String.padLeft 2 '0'
            in
            ( { model | line = line + 1 }, cout <| format anshour ++ ":" ++ format ansminute )


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
