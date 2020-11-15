module Form exposing (main)


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
type alias IndexedMemo =
    { body : String
    , index : Int
    }
type alias Model =
    { input : String
    , memos : List IndexedMemo
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
    | Delete Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }
        Submit ->
            { model
                | input = ""
                , memos = reindex ({ body = model.input, index = 0 } :: model.memos)
            }
        Delete index ->
            { model
                | input = ""
                , memos = reindex (List.append (List.take index model.memos) (List.drop (index+1) model.memos))
            }

reindex : List IndexedMemo -> List IndexedMemo
reindex memos =
    List.indexedMap (\i memo -> { memo | index = i }) memos

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Submit ]
            [ input [ onInput Input, value model.input ] []
            , button
                [ disabled (String.isEmpty (String.trim model.input)) ]
                [ text "Submit" ]
            ]
        , ul [] (List.map viewMemo model.memos)
        ]
viewMemo : IndexedMemo -> Html Msg
viewMemo memo =
    li []
        [ text ((String.fromInt memo.index) ++ "：" ++ memo.body)
        , button [ onClick (Delete memo.index) ] [ text "削除" ]
        ]
