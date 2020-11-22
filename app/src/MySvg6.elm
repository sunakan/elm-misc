module MySvg6 exposing (main)

import Browser
import Html exposing (Html, div, h1, text, button)
import Html.Events exposing (onClick)
import Random
import TypedSvg exposing (rect, circle, svg)
import TypedSvg.Attributes exposing (x, y, cx, cy, fill, r, stroke, strokeWidth, viewBox)
import TypedSvg.Attributes.InPx exposing (width, height)
import TypedSvg.Types exposing (Paint(..), px)
import TypedSvg.Core exposing (Svg)
import Color


-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL

type alias SvgField =
    { width : Float
    , height : Float
    }

type alias Dice =
    { number : Int
    }

type alias Model =
    { dice : Dice
    , svgField : SvgField
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model { number = 1 } { width = 120, height = 120 }
    , Cmd.none
    )


-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newNumber ->
            ( let
                dice = model.dice
                newDice = { dice | number = newNumber }
              in { model | dice = newDice }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ svg
            [ width model.svgField.width, height model.svgField.height ]
            ( List.append [diceFace model.svgField] (diceNumber model.dice) )
        , h1 [] [ text (String.fromInt model.dice.number) ]
        , button [ onClick Roll ] [ text "ダイスロール" ]
        ]


diceFace : SvgField -> Svg msg
diceFace svgField =
    rect
        [ x (px 0)
        , y (px 0)
        , width svgField.width
        , height svgField.height
        , fill <| Paint Color.white
        , strokeWidth (px 4)
        , stroke <| Paint Color.black
        ]
        []

diceNumber : Dice -> List (Svg msg)
diceNumber dice =
    if dice.number == 1 then one dice
    else if dice.number == 2 then two dice
    else if dice.number == 3 then three dice
    else if dice.number == 4 then four dice
    else if dice.number == 5 then five dice
    else six dice

one : Dice -> List (Svg msg)
one dice =
    [ circle
        [ cx (px 60)
        , cy (px 60)
        , r (px (60*0.4))
        , fill <| Paint Color.red
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.8 0.2 0.2 1
        ]
        []
    ]

two : Dice -> List (Svg msg)
two dice =
    [ circle
        [ cx (px 40)
        , cy (px 40)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 80)
        , cy (px 80)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    ]


three : Dice -> List (Svg msg)
three dice =
    [ circle
        [ cx (px 30)
        , cy (px 30)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 60)
        , cy (px 60)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 90)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    ]

four: Dice -> List (Svg msg)
four dice =
    [ circle
        [ cx (px 30)
        , cy (px 30)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 30)
        , cy (px 90)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 30)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 90)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    ]

five: Dice -> List (Svg msg)
five dice =
    [ circle
        [ cx (px 30)
        , cy (px 30)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 30)
        , cy (px 90)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 30)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 90)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 60)
        , cy (px 60)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    ]

six: Dice -> List (Svg msg)
six dice =
    [ circle
        [ cx (px 30)
        , cy (px 25)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 30)
        , cy (px 60)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 30)
        , cy (px 95)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 25)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 60)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    , circle
        [ cx (px 90)
        , cy (px 95)
        , r (px (15))
        , fill <| Paint Color.black
        , strokeWidth (px 2)
        , stroke <| Paint <| Color.rgba 0.2 0.2 0.2 1
        ]
        []
    ]
