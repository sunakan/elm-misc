module Form2 exposing (main)

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


type alias IndexedMemo =
    { body : String
    , index : Int
    }


type alias Model =
    { input : String
    , memos : List IndexedMemo
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
    | Check Int
    | Uncheck Int
    | Delete


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }

        Submit ->
            { model
                | input = ""
                , memos = { body = model.input, index = List.length model.memos } :: model.memos
            }

        Check index ->
            { model | checked = Set.insert index model.checked }

        Uncheck index ->
            { model | checked = Set.remove index model.checked }

        Delete ->
            { model
                | memos = List.reverse (reindex (List.reverse (List.filter (\memo -> not (Set.member memo.index model.checked)) model.memos)))
                , checked = Set.empty
            }


reindex : List IndexedMemo -> List IndexedMemo
reindex memos =
    List.indexedMap (\i memo -> { memo | index = i }) memos



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ disabled (Set.isEmpty model.checked), onClick Delete ] [ text "Delete" ]
        , Html.form [ onSubmit Submit ]
            [ input [ onInput Input, value model.input ] []
            , button
                [ disabled (String.isEmpty (String.trim model.input)) ]
                [ text "Submit" ]
            ]
        , ul [] (List.map2 viewMemo model.memos (List.map (\memo -> Set.member memo.index model.checked) model.memos))
        ]


viewMemo : IndexedMemo -> Bool -> Html Msg
viewMemo memo isChecked =
    li []
        [ text (String.fromInt memo.index ++ "：" ++ memo.body)
        , input
            [ type_ "checkbox"
            , if isChecked then
                onClick (Uncheck memo.index)

              else
                onClick (Check memo.index)
            , checked isChecked
            ]
            [ text "削除" ]
        ]
