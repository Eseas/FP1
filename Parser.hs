module Parser where

data Point = Point (Integer, Integer)
  deriving Show

data Move = A | Move { point  :: Point
                 , symbol :: String
                 , id     :: String
                 , prev   :: Move
                 } deriving Show


msg :: String
msg = "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"QwjRrYJKKctJh\"}"

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

turboParse' :: String -> Move -> (Move, String)
-- c - point
turboParse' ('{':'\"':'c':'\"':':':' ':rest) (Move iniPoint ini1 ini2 A) =
  turboParse' rest1 newMove
  where
    (point, rest1) = parsePoint rest
    newMove = Move point "" "" A
-- v - symbol
turboParse' ('\"':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 A) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint stringValue "" A
-- id
turboParse' ('\"':'i':'d':'\"':':':' ':rest) (Move iniPoint ini1 ini2 A) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint ini1 stringValue A
-- prev
turboParse' ('\"':'i':'d':'\"':':':' ':rest) (Move iniPoint ini1 ini2 A) =
  turboParse' rest1 newMove
  where
    (stringValue, rest1) = parseString rest
    newMove = Move iniPoint ini1 stringValue A
turboParse' rest (Move iniPoint ini1 ini2 A) =
  ((Move iniPoint ini1 ini2 A), rest)