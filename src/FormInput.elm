module FormInput exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Set exposing (Set)


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
    , checked : Set Int
    }


init : Model
init =
    { input = ""
    , memos = []
    , checked = Set.empty
    }



-- UPDATE


type Msg
    = Input String
    | Submit
    | Check Int Bool
    | Delete


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

        -- チェックされたメモを削除対象に追加、チェックの外されたメモを削除対象から削除する
        Check index checked ->
            if checked then
                { model | checked = Set.insert index model.checked }

            else
                { model | checked = Set.remove index model.checked }

        -- チェックされたメモを削除する
        Delete ->
            let
                newMemos =
                    List.indexedMap Tuple.pair model.memos
                        |> List.filter (\pair -> Set.member (Tuple.first pair) model.checked |> not)
                        |> List.map Tuple.second
            in
            { model | memos = newMemos, checked = Set.empty }


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Submit ]
            [ input [ value model.input, onInput Input ] []
            , button
                [ disabled <| String.isEmpty <| String.trim model.input ]
                [ text "Submit" ]
            ]
        , button
            [ disabled <| Set.isEmpty model.checked, onClick Delete ]
            [ text "Delete" ]
        , ul [] (List.indexedMap viewMemo model.memos)
        ]


viewMemo : Int -> String -> Html Msg
viewMemo index memo =
    li [] [ input [ type_ "checkbox", onCheck <| Check index ] [], text memo ]
