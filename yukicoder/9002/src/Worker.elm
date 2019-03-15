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
            in
            ( model
            , cout <|
                String.join "\n"
                    (List.repeat n 0
                        |> List.indexedMap Tuple.pair
                        |> List.map Tuple.first
                        |> List.map (\i -> i + 1)
                        |> List.map
                            (\i ->
                                if modBy 15 i == 0 then
                                    "FizzBuzz"

                                else if modBy 5 i == 0 then
                                    "Buzz"

                                else if modBy 3 i == 0 then
                                    "Fizz"

                                else
                                    String.fromInt i
                            )
                    )
            )


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
