module Parser where

import Entities

createMove :: String -> Either String (Move, String)
createMove rest =
    case parse rest (Move (Point 0 0) 'e' "" Entities.Empty) of
        Right (move, rest1) -> Right (move, rest1)
        Left errorMsg       -> Left errorMsg

parse :: String -> Move -> Either String (Move, String)
parse rest0 (Move iniPoint iniSym iniId prevMove) =
    case rest0 of
    ('{':'}':rest) ->
        Right (Entities.Empty, rest)
    ('{':rest) ->
        parse rest (Move iniPoint iniSym iniId prevMove)
    ('\"':'c':'\"':':':' ':rest) ->
        case parsePoint rest of
            Left msg -> Left msg
            Right (newPoint, rest1) ->
                parse rest1 updMove
                where
                    updMove = Move newPoint iniSym iniId prevMove
    ('\"':'v':'\"':':':' ':rest) ->
        case parseString rest of
            Left msg -> Left msg
            Right ([charValue], rest1) ->
                parse rest1 updMove
                where
                    updMove = Move iniPoint charValue iniId prevMove
    (',':' ':'\"':'i':'d':'\"':':':' ':rest) ->
        case parseString rest of
            Left msg -> Left msg
            Right (stringValue, rest1) ->
                parse rest1 updMove
                where
                    updMove = Move iniPoint iniSym stringValue prevMove
    (',':' ':'\"':'p':'r':'e':'v':'\"':':':' ':rest) ->
        case createMove rest of
            Left msg -> Left msg
            Right (newMove, rest1) ->
                parse rest1 (Move iniPoint iniSym iniId newMove)
    ('}':rest) ->
        Right ((Move iniPoint iniSym iniId prevMove), rest)
    rest ->
        Left ("ERROR: Wrong protocol. rest = " ++ rest)

parsePoint :: String -> Either String (Point, String)
parsePoint ('{':rest) =
    case parseInt rest of
        Right (first, ',':' ':rest1) ->
            case parseInt rest1 of
                Right (second, '}':',':' ':rest2) ->
                    Right (Point first second, rest2)
                Left errorMsg -> Left errorMsg
        Left errorMsg -> Left errorMsg

parseInt :: String -> Either String (Int, String)
parseInt ('\"':_:'\"':':':' ':value:rest) =
    Right (read [value], rest)
parseInt _ =
    Left "ERROR: Parsing Int failed. Must match: ('\"':_:'\"':':':' ':value:rest)."

parseString :: String -> Either String (String, String)
parseString ('\"':rest) =
    let
        iAsStr = takeWhile (/= '\"') rest
        strLenght = length iAsStr + 1
        rest1 = drop strLenght rest
        in Right (iAsStr, rest1)
parseString _ =
    Left "ERROR: Parsing String failed. Must match: ('\"':rest)."
