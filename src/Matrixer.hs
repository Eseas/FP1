module Matrixer where
import Data.List        -- elemIndex
import Data.Sequence    -- update
import Data.Foldable    -- toList
import Entities

m :: String
m = "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"

indices :: [(Int, Int, Char)]
indices = concat [[(x, y, ' ') | x <- [0..2]] | y <- [0..2]]

fillMatrix :: Entities.Move -> [(Int, Int, Char)] -> [(Int, Int, Char)]
fillMatrix Entities.Empty acc =
    acc
fillMatrix move acc =
    fillMatrix previousTurn newAcc
    where
        Entities.Point (x, y) = point move
        sym = symbol move
        idx = position (x, y, ' ') acc
        newAcc = changeElement idx (x, y, sym) acc
        previousTurn = prev move

changeElement idx newElem acc =
    newAcc
    where
        (beginning, _:ending) = Data.List.splitAt idx acc
        newAcc = beginning ++ newElem : ending

position :: Eq a => a -> [a] -> Int
position i xs =
    case i `elemIndex` xs of
        Just n  -> n
        Nothing -> error "Could not determine position."
