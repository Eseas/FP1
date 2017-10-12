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
      strLenght = Data.Foldable.length iAsStr + 3
      rest1 = Data.List.drop strLenght rest
      in (iAsStr, rest1)
parseString _ =
  error "String expected"

indices = concat [[(x, y, ' ') | x <- [1..3]] | y <- [1..3]]

fillMatrix :: Move -> [(Integer, Integer, Char)] -> [(Integer, Integer, Char)]
fillMatrix (Move _ _ _ Parser.Empty) acc =
--    putStrLn "last"
    acc
fillMatrix move acc =
    fillMatrix previousTurn newAcc
    where
        Point (x, y) = point move
        sym = symbol move
        idx = case elemIndex (x, y, ' ') (takeWhile (<= (x, y, ' ')) acc) of
            Just n  -> n
            Nothing -> error "Could not extract index."
        newAcc = toList(update idx (x, y, sym) $ fromList acc)
        previousTurn = prev move
--        putStrLn "full"




solve :: String -> IO ()
solve rest =
    putStrLn "full"
    where
        (move, rest) = createMove rest
        matrix = fillMatrix move indices

test :: [(Integer, Integer, Char)]
test =
    [(1,2,'c'),(1,2,'d')]

--createMatrix :: Move -> [[Char]]
--createMatrix move =
--  Point (x, y) = point Move
--
--takePoint' ::

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