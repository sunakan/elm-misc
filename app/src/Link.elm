module Link exposing (..)
import Html exposing (Html, a, text, div, ul, li, h1)
import Html.Attributes exposing (href)

main : Html msg
main =
  div []
    [ h1 [] [text "Sunakan Links"]
    , ul []
      [ linkItem "https://scrapbox.io/sunabako/" "Scrapbox"
      , linkItem "https://github.com/sunakan/" "Github"
      , linkItem "https://lapras.com/public/ZQTTQGP" "LAPRAS"
      ]
    ]

linkItem : String -> String -> Html msg
linkItem url text_ =
  li [] [ a [href url] [text text_] ]
