module Solver where
import Data.List        -- elemIndex
import Data.Sequence    -- update
import Data.Foldable    -- toList
import Parser
import Matrixer

m :: String
m = "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"

finalMove :: String -> Either String (Maybe (Int, Int, Char))
finalMove msg =
    Right (makeAMove matrix)
    where
        matrix = solve msg

solve :: String -> [(Int, Int, Char)]
solve message =
    matrix
    where
        (move, rest) = createMove message
        matrix = Matrixer.fillMatrix move Matrixer.indices

makeAMove :: [(Int, Int, Char)] -> Maybe (Int, Int, Char)
makeAMove [] = Nothing
makeAMove (elem:restElem) =
    case elem of
        (x, y, ' ') -> Just (x, y, 'x')
        _ -> makeAMove restElem
