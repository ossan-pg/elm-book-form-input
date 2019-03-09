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
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    text ""
