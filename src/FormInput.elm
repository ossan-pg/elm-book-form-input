module FormInput exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { input : String
    , memos : List String
    }


init : Model
init =
    { input = ""
    , memos = []
    }



-- UPDATE


type Msg
    = Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        -- 入力文字列を更新する
        Input input ->
            { model | input = input }

        -- 入力文字列をリセットする＋最新のメモを追加する
        Submit ->
            { model
                | input = ""
                , memos = model.input :: model.memos
            }


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Submit ]
            [ input [ value model.input, onInput Input ] []
            , button
                [ disabled (String.isEmpty <| String.trim model.input) ]
                [ text "Submit" ]
            , ul [] (List.map viewMemo model.memos)
            ]
        ]


viewMemo : String -> Html Msg
viewMemo memo =
    li [] [ text memo ]
