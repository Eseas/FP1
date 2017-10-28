module Parser where
import Data.List        -- elemIndex
import Data.Sequence    -- update
import Data.Foldable    -- toList
import Matrixer
import Entities

parsePoint :: String -> (Point, String)
parsePoint ('{':rest) =
  (Point (first, second), rest2)
  where
    (first, ',':' ':rest1) = parseInt rest
    (second, '}':',':' ':rest2) = parseInt rest1

parseInt :: String -> (Int, String)
parseInt ('\"':_:'\"':':':' ':value:rest) =
  (read [value], rest)
parseInt _ =
  error "Int expected"

parseString :: String -> (String, String)
parseString ('\"':rest) =
  let
      iAsStr = takeWhile (/= '\"') rest
      strLenght = Data.Foldable.length iAsStr + 3
      rest1 = Data.List.drop strLenght rest
      in (iAsStr, rest1)
parseString _ =
  error "String expected"

makeAMove :: [(Int, Int, Char)] -> Maybe (Int, Int, Char)
makeAMove [] = Nothing
makeAMove (elem:restElem) =
    case elem of
        (x, y, ' ') -> Just (x, y, 'x')
        _ -> makeAMove restElem

createMove :: String -> (Move, String)
createMove rest =
  (move, rest1)
  where
    (move, rest1) = turboParse' rest (Move (Point (0,0)) 'e' "" Entities.Empty)

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
