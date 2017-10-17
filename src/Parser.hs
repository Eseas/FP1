module Parser where
import Data.List        -- elemIndex
import Data.Sequence    -- update
import Data.Foldable    -- toList

data Point = Point (Integer, Integer)
  deriving Show

data Move = Empty | Move { point  :: Point
                         , symbol :: Char
                         , id     :: String
                         , prev   :: Move
                         } deriving Show

m :: String
m = "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"

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
      strLenght = Data.Foldable.length iAsStr + 3
      rest1 = Data.List.drop strLenght rest
      in (iAsStr, rest1)
parseString _ =
  error "String expected"

indices = concat [[(x, y, ' ') | x <- [0..2]] | y <- [0..2]]

fillMatrix :: Move -> [(Integer, Integer, Char)] -> [(Integer, Integer, Char)]
fillMatrix Parser.Empty acc =
    acc
fillMatrix move acc =
    fillMatrix previousTurn newAcc
    where
        Point (x, y) = point move
        sym = symbol move
        idx = position (x, y, ' ') acc
        newAcc = changeElement idx (x, y, sym) acc
        previousTurn = prev move

changeElement idx newElem acc =
    newAcc
    where
        (beginning, _:ending) = Data.List.splitAt idx acc
        newAcc = beginning ++ newElem : ending

finalMove :: String -> Either String (Maybe (Int, Int, Char))
finalMove msg =
    Right (makeAMove matrix)
    where
        matrix = solve msg





test :: Int -> Either String (Maybe (Int, Int, Char))
test 1 = Left "Awesome!"
test 2 = Right (Just (1,2,'x'))


solve :: String -> [(Integer, Integer, Char)]
solve message =
    matrix
    where
        (move, rest) = createMove message
        matrix = fillMatrix move indices

position :: Eq a => a -> [a] -> Int
position i xs =
    case i `elemIndex` xs of
        Just n  -> n
        Nothing -> error "Could not determine position."

makeAMove :: [(Integer, Integer, Char)] -> Maybe (Integer, Integer, Char)
makeAMove [] = Nothing
makeAMove (elem:restElem) =
    case elem of
        (x, y, ' ') -> Just (x, y, 'x')
        _ -> makeAMove restElem

createMove :: String -> (Move, String)
createMove rest =
  (move, rest1)
  where
    (move, rest1) = turboParse' rest (Move (Point (0,0)) 'e' "" Parser.Empty)

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
turboParse' ('\"':'p':'r':'e':'v':'\"':':':' ':rest) (Move iniPoint ini1 ini2 Parser.Empty) =
  ((Move iniPoint ini1 ini2 newMove), rest1)
  where
    (newMove, rest1) = createMove rest
turboParse' rest (Move iniPoint ini1 ini2 prevMove) =
  ((Move iniPoint ini1 ini2 prevMove), rest)


