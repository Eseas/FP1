module Parser where

data Point = Point (Integer, Integer)
  deriving Show

data Move = Empty | Move { point  :: Point
                         , symbol :: String
                         , id     :: String
                         , prev   :: Move
                         } deriving Show

m :: String
m = "{\"c\": {\"0\": 1, \"1\": 1}, \"v\": \"x\", \"id\": \"Uw\", \"prev\": {\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"Uw\"}}"

parsePoint :: String -> (Point, String)
parsePoint ('{':rest) =
  (Point (first, second), rest2)
  where
    (first, ',':' ':rest1) = parseInt rest
    (second, '}':',':' ':rest2) = parseInt rest1

parseInt :: String -> (Integer, String)
parseInt ('\"':_:'\"':':':' ':value:rest) =
  (read [value], rest)
parseInt _ =
  error "Integer expected"

parseString :: String -> (String, String)
parseString ('\"':rest) =
  let
      iAsStr = takeWhile (/= '\"') rest
      strLenght = length iAsStr + 3
      rest1 = drop strLenght rest
      in (iAsStr, rest1)
parseString _ =
  error "String expected"

-- indices = [[(x, y) | x <- [1..3]] | y <- [1..3]]
--solve :: String -> xxx
--solve rest =
--  matrix = createMatrix move
--  where
--    (move, rest) = createMove rest
--
--
--createMatrix :: Move -> [[Char]]
--createMatrix move =
--  Point (x, y) = point Move
--
--takePoint' ::

createMove :: String -> (Move, String)
createMove rest =
  (move, rest1)
  where
    (move, rest1) = turboParse' rest (Move (Point (0,0)) "" "" Empty)

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
    newMove = Move point "" "" prevMove
-- v - symbol
turboParse' ('\"':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint stringValue "" prevMove
-- id
turboParse' ('\"':'i':'d':'\"':':':' ':rest) (Move iniPoint ini1 ini2 prevMove) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint ini1 stringValue prevMove
-- prev
turboParse' ('\"':'p':'r':'e':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 Empty) =
  ((Move iniPoint ini1 ini2 newMove), rest1)
  where
    (newMove, rest1) = createMove rest
turboParse' rest (Move iniPoint ini1 ini2 prevMove) =
  ((Move iniPoint ini1 ini2 prevMove), rest)