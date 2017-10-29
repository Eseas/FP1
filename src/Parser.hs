module Parser where
import Data.List        -- elemIndex
import Data.Sequence    -- update
import Data.Foldable    -- toList
import Matrixer
import Entities

createMove :: String -> (Move, String)
createMove rest =
  (move, rest1)
  where
    (move, rest1) = turboParse' rest (Move (Point (0,0)) 'e' "" Entities.Empty)

createMove2 :: String -> Either String (Move, String)
createMove2 rest =
  result
  where
    result = case parse rest (Move (Point (0,0)) 'e' "" Entities.Empty) of
      Right (move, rest1) ->
        Right (move, rest1)
      Left errorMsg ->
        Left errorMsg

parsePoint :: String -> (Point, String)
parsePoint ('{':rest) =
  (Point (first, second), rest2)
  where
    (first, ',':' ':rest1) = parseInt rest
    (second, '}':',':' ':rest2) = parseInt rest1

parsePoint2 :: String -> Either String (Point, String)
parsePoint2 ('{':rest) =
  Right (Point (first, second), rest2)
  where
    (first, ',':' ':rest1) = parseInt rest
    (second, '}':',':' ':rest2) = parseInt rest1

parseInt :: String -> (Int, String)
parseInt ('\"':_:'\"':':':' ':value:rest) =
  (read [value], rest)
parseInt _ =
  error "Int expected"

parseInt2 :: String -> Either String (Int, String)
parseInt2 ('\"':_:'\"':':':' ':value:rest) =
  Right (read [value], rest)
parseInt2 _ =
  Left "parseInt failed. Must match: '\"':_:'\"':':':' ':value:rest"

parseString :: String -> (String, String)
parseString ('\"':rest) =
  let
      iAsStr = takeWhile (/= '\"') rest
      strLenght = Data.Foldable.length iAsStr + 3
      rest1 = Data.List.drop strLenght rest
      in (iAsStr, rest1)
parseString _ =
  error "String expected"

parseString2 :: String -> Either String (String, String)
parseString2 ('\"':rest) =
  let
      iAsStr = takeWhile (/= '\"') rest
      strLenght = Data.Foldable.length iAsStr + 3
      rest1 = Data.List.drop strLenght rest
      in Right (iAsStr, rest1)
parseString2 _ =
  Left "String expected"

parse :: String -> Move -> Either String (Move, String)
parse rest0 (Move iniPoint ini1 ini2 prevMove) =
  case updatedMove of
      Left updatedMove  -> Left updatedMove
      Right updatedMove -> Right updatedMove
  where
    updatedMove = case rest0 of
      ('{':rest) ->
        parse rest (Move iniPoint ini1 ini2 prevMove)
      ('\"':'c':'\"':':':' ':rest) ->
        case parsePoint2 rest of
          Left msg ->
            Left msg
          Right (newPoint, rest1) ->
            parse rest1 newMove
            where
              newMove = Move newPoint 'e' "" prevMove
      ('\"':'v':'\"':':':' ':rest) ->
        case parseString2 rest of
          Left msg ->
            Left msg
          Right ([charValue], rest1) ->
            parse rest1 newMove
              where
                newMove = Move iniPoint charValue "" prevMove
      ('\"':'i':'d':'\"':':':' ':rest) ->
        case parseString2 rest of
          Left msg ->
            Left msg
          Right (stringValue, rest1) ->
            parse rest1 newMove
              where
                newMove = Move iniPoint ini1 stringValue prevMove
      ('\"':'p':'r':'e':'v':'\"':':':' ':rest) ->
        case createMove2 rest of
          Left msg ->
            Left msg
          Right (newMove, rest1) ->
            parse rest1 (Move iniPoint ini1 ini2 newMove)
      rest ->
        Right ((Move iniPoint ini1 ini2 prevMove), rest)
-- parse last
--   return what have

turboParse2' :: String -> Move -> Either String (Move, String)
turboParse2' ('\"':'c':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  -- turboParse' rest1 newMove
  case result of
    Left errorMsg3 ->
      Left "Fuck"
    Right goodResult ->
      Right goodResult
  where
    result = case parsePoint2 rest of
      Right (point, rest1) ->
        turboParse2' rest1 newMove
        where
          newMove = Move point 'e' "" prevMove
      Left errorMsg ->
        Left "fuck2"
turboParse2' _ _ =
  Left "Completely fucked up"

turboParse' :: String -> Move -> (Move, String)
-- init move
turboParse' ('{':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest newMove
  where
    newMove = Move iniPoint ini1 ini2 prevMove
-- c - point
turboParse' ('\"':'c':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest1 newMove
  where
    (point, rest1) = parsePoint rest
    newMove = Move point 'e' "" prevMove
-- v - symbol
turboParse' ('\"':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest1 newMove
  where
    ([charValue], rest1) = parseString rest
    newMove = Move iniPoint charValue "" prevMove
-- id
turboParse' ('\"':'i':'d':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint ini1 stringValue prevMove
-- prev
turboParse' ('\"':'p':'r':'e':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 Entities.Empty) =
  ((Move iniPoint ini1 ini2 newMove), rest1)
  where
    (newMove, rest1) = createMove rest
turboParse' rest (Move iniPoint ini1 ini2 prevMove) =
  ((Move iniPoint ini1 ini2 prevMove), rest)
