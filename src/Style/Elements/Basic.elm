module Style.Elements.Basic exposing (..)

{-|

# Useful elements for layout

@docs centered, completelyCentered, split, floatLeft, floatRight, floatTopLeft, floatTopRight

@docs div, table

# Common Text Elements

@docs text, i, b, u, s, sup, sub, break, divider, sup, sub, dottedList, numberedList

-}

import Html
import Html.Attributes
import Style exposing (..)
import Style.Elements exposing (..)


{-| Flow child elements horizontally to the right and center them.  They will be aligned to the top.
-}
centered : List (Html.Attribute msg) -> List (Element msg) -> Element msg
centered =
    element
        { empty
            | spacing = all 10
            , layout =
                flowRight
                    { wrap = True
                    , horizontal = alignCenter
                    , vertical = alignTop
                    }
        }


{-| Flow child elements horizontally to the right.  Center them horizontally and vertically.
-}
completelyCentered : List (Html.Attribute msg) -> List (Element msg) -> Element msg
completelyCentered =
    element
        { empty
            | spacing = all 10
            , layout =
                flowRight
                    { wrap = True
                    , horizontal = alignCenter
                    , vertical = verticalCenter
                    }
        }


{-| Flow child elements horizontally, but have them keep to the edges.  They will be vertically centered.  They will not wrap.
-}
split : List (Html.Attribute msg) -> List (Element msg) -> Element msg
split =
    element
        { empty
            | spacing = all 10
            , layout =
                flowRight
                    { wrap = False
                    , horizontal = justify
                    , vertical = verticalCenter
                    }
        }


{-| Float a single element to the left
-}
floatLeft : Element a -> Element a
floatLeft floater =
    element
        { empty
            | float = Just Style.floatLeft
        }
        []
        [ floater ]


{-|
-}
floatRight : Element a -> Element a
floatRight floater =
    element
        { empty
            | float = Just Style.floatRight
        }
        []
        [ floater ]


{-| Float a single element to the left.  "topLeft" means it will ignore top spacing that the parent specifies and use 0px insteas.
-}
floatTopLeft : Element a -> Element a
floatTopLeft floater =
    element
        { empty
            | float = Just Style.floatTopLeft
        }
        []
        [ floater ]


{-|
-}
floatTopRight : Element a -> Element a
floatTopRight floater =
    element
        { empty
            | float = Just Style.floatTopRight
        }
        []
        [ floater ]


{-|
-}
table : List (Html.Attribute msg) -> List (Element msg) -> Element msg
table =
    elementAs "table"
        { empty
            | layout = tableLayout
        }



-----------------
-- Text Elements
-- Most of these take either no arguments or a single piece of text.
-- This limits what you can do with them but cleans up text areas of the UI code.
-----------------


{-| -}
div : List (Html.Attribute msg) -> List (Element msg) -> Element msg
div attrs children =
    html Html.div attrs children


{-|
-}
text : String -> Element msg
text str =
    html (\_ _ -> Html.text str) [] []


{-| Italicize text
-}
i : String -> Element msg
i str =
    html
        Html.i
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| Bold text
-}
b : String -> Element msg
b str =
    html
        Html.b
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| Strike-through text
-}
s : String -> Element msg
s str =
    html
        Html.s
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| Underline text
-}
u : String -> Element msg
u str =
    html
        Html.u
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| Underline text
-}
sub : String -> Element msg
sub str =
    html
        Html.sub
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| Underline text
-}
sup : String -> Element msg
sup str =
    html
        Html.sup
        [ Html.Attributes.class "inline"
        ]
        [ text str ]


{-| A line break.
-}
br : Element msg
br =
    html Html.br [ Html.Attributes.class "inline" ] []


{-| A dividing line rendered as an 'hr' element
-}
divider : Element msg
divider =
    html
        Html.hr
        [ Html.Attributes.style
            [ ( "height", "1px" )
            , ( "border", "none" )
            , ( "background-color", "#ddd" )
            ]
        , Html.Attributes.class "inline"
        ]
        []


{-| An unordered list that sets all children as `li` elements.
-}
dottedList : List (Html.Attribute msg) -> List (Element msg) -> Element msg
dottedList attrs children =
    html
        Html.ul
        attrs
        (List.map (\child -> html Html.li [ Html.Attributes.class "inline" ] [ child ]) children)


{-| An ordered list that sets all children as `li` elements.
-}
numberedList : List (Html.Attribute msg) -> List (Element msg) -> Element msg
numberedList attrs children =
    html
        Html.ol
        attrs
        (List.map
            (\child ->
                html Html.li [ Html.Attributes.class "inline" ] [ child ]
            )
            children
        )
