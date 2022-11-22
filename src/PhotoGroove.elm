module PhotoGroove exposing (main)

import Browser
import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { photos : List { url : String }
    , selectedUrl : String
    }


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    }


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


view model =
    div [ class "bg-slate-800 text-white w-full" ]
        [ h1 [ class "text-center text-3xl font-bold mt-8 mb-8" ] [ text "Photo Groove" ]
        , div [ class "flex mx-auto justify-center items-start" ]
            [ div [ id "thumbnails", class "flex col-span-3" ]
                (List.map
                    (viewThumbnail model.selectedUrl)
                    model.photos
                )
            ]
        , div [ class "flex justify-center" ]
            [ img
                [ src (urlPrefix ++ "large/" ++ model.selectedUrl), class "col-span-1" ]
                []
            ]
        ]


viewThumbnail selectedUrl thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , class "border-4"
        , classList
            [ ( "border-green-500", selectedUrl == thumb.url )
            , ( "border-transparent", selectedUrl /= thumb.url )
            ]
        , onClick { description = "ClickedPhoto", data = thumb.url }
        ]
        []


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
