module Main exposing (main)

import Html exposing (Html, br, button, div, p, text, textarea)
import Html.Events exposing (onClick, onDoubleClick, onInput)

-- Model
type alias Model = {
    mode: Mode,
    contents: String
}
type Mode = Paragraph | Form

toggle : Mode -> Mode
toggle mode = case mode of
    Paragraph -> Form
    Form -> Paragraph

initModel : Model
initModel = { mode = Paragraph, contents = "Double-click me!" }

-- View
view : Model -> Html Msg
view {mode, contents} = case mode of
    Paragraph -> paragraph contents
    Form -> form contents

-- HTML view as a paragraph
paragraph : String -> Html Msg
paragraph contents =
    div []
        [ p [onDoubleClick Toggle] [text contents]
        ]

-- HTML view as a form with a textarea and a button
form : String -> Html Msg
form contents =
    div []
        [ textarea [onInput ChangeText] [text contents]
        , br [] []
        , button [onClick Toggle] [text "Submit"]
        ]

-- Update
type Msg = Toggle | ChangeText String

-- Toggle the mode or modify the text contents, depending on incoming events
update : Msg -> Model -> Model
update msg model = case msg of
    Toggle -> { model | mode = toggle model.mode }
    ChangeText newContents -> { model | contents = newContents }

main = Html.beginnerProgram { model = initModel, view = view, update = update }
