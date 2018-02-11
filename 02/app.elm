module Main exposing (main)

import Html exposing (Html, br, button, div, p, text, textarea)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onDoubleClick, onInput)
import List exposing (filter, map, range)

-- Model
type alias Model = {
    tiles: List Int -- The list of visible tiles in the order they appear in the document
}

tileCount = 20

initModel : Model
initModel = Model (range 1 tileCount) -- All ten tiles 1-10 are visible at first

-- View
view : Model -> Html Msg
view {tiles} =
    div [] -- The document consists of a div containing the following:
        [ button [onClick Reset] [text "Reset"] -- The reset button emits a Reset message (see Update)
        , button [onClick Clear] [text "Clear"] -- The clear button emits a Clear message (see Update)
        , div [class "tile-container"] (map toTile tiles) -- Apply toTile to each number in the model
        ]

-- Turn an integer into an HTML element representing a tile
toTile : Int -> Html Msg
toTile n = 
    div [class "tile"]
        [div [class "close", onClick (Hide n)] [text (toString n ++ " ×")] -- Emit a Hide n message on click
        ]

-- Update
type Msg = Reset | Clear | Hide Int -- These are the possible messages that can be produced

-- Handle a message by updating the model
update : Msg -> Model -> Model
update msg model = case msg of
    Reset  -> initModel -- Set the model back to its initial state
    Clear  -> { model | tiles = [] } -- Make all tiles invisible
    Hide n -> { model | tiles = filter (\i -> i /= n) model.tiles } -- Hide the nth tile

main = Html.beginnerProgram { model = initModel, view = view, update = update }
