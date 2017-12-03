module Matrixer where

import Data.List        -- elemIndex
import Entities

indices :: [(Int, Int, Char)]
indices = concat [[(x, y, ' ') | x <- [0..2]] | y <- [0..2]]

fillMatrix :: Entities.Move -> ([(Int, Int, Char)], (Int, Int, Char)) -> Either String ([(Int, Int, Char)], (Int, Int, Char))
fillMatrix Entities.Empty (acc, lastMove) =
    Right (acc, lastMove)
fillMatrix move (acc, lastMove) =
    case position (x, y, sym) acc of
        -1 ->
            fillMatrix previousTurn (newAcc, newLastMove)
            where
                idx = position (x, y, ' ') acc
                newAcc = changeElement idx (x, y, sym) acc
                previousTurn = prev move
                newLastMove = case lastMove of
                  (-1, -1, ' ') -> (x, y, sym)
                  _ -> lastMove
        _ ->
            Left "ERROR: One cell has multiple moves."
    where
        Entities.Point x y = point move
        sym = symbol move

changeElement idx newElem acc =
    newAcc
    where
        (beginning, _:ending) = Data.List.splitAt idx acc
        newAcc = beginning ++ newElem : ending

position :: Eq a => a -> [a] -> Int
position i xs =
    case i `elemIndex` xs of
        Just n  -> n
        Nothing -> -1

checkIfFreeAndInside :: [(Int, Int, Char)] -> (Int, Int, Char) -> Either String (Int, Int, Char)
checkIfFreeAndInside matrix (x, y, sym)
  | (x < 0) || (x > 2) || (y < 0) || (y > 2) = Left "Outside"
  | otherwise = case position (x, y, sym) matrix of
                  -1 -> checkGameOverOnMove matrix (x, y, sym)
                  _ -> Left "Occupied"

checkGameOverOnMove :: [(Int, Int, Char)] -> (Int, Int, Char) -> Either String (Int, Int, Char)
checkGameOverOnMove matrix (tryx, tryy, trysym) =
      case position (tryx, tryy, ' ') matrix of
        -1 -> Left "error position"
        idx ->
          case checkGameOver newAcc of
            Right newAcc -> Right (tryx, tryy, trysym)
            Left e -> Left e
          where
            newAcc = changeElement idx (tryx, tryy, 'x') matrix

checkGameOver :: [(Int, Int, Char)] -> Either String [(Int, Int, Char)]
checkGameOver matrix =
    case matrix of
        [(0,0, 'x'),(1,0,'x'),(2,0,'x'),(0,1,_  ),(1,1, _ ),(2,1, _ ),(0,2, _ ),(1,2, _ ),(2,2, _ )] -> Left "ERROR: Game already over."
        [(0,0,  _ ),(1,0, _ ),(2,0, _ ),(0,1,'x'),(1,1,'x'),(2,1,'x'),(0,2, _ ),(1,2, _ ),(2,2, _ )] -> Left "ERROR: Game already over."
        [(0,0,  _ ),(1,0, _ ),(2,0, _ ),(0,1, _ ),(1,1, _ ),(2,1, _ ),(0,2,'x'),(1,2,'x'),(2,2,'x')] -> Left "ERROR: Game already over."
        [(0,0, 'x'),(1,0, _ ),(2,0, _ ),(0,1,'x'),(1,1, _ ),(2,1, _ ),(0,2,'x'),(1,2, _ ),(2,2, _ )] -> Left "ERROR: Game already over."
        [(0,0,  _ ),(1,0,'x'),(2,0, _ ),(0,1, _ ),(1,1,'x'),(2,1, _ ),(0,2, _ ),(1,2,'x'),(2,2, _ )] -> Left "ERROR: Game already over."
        [(0,0,  _ ),(1,0, _ ),(2,0,'x'),(0,1, _ ),(1,1, _ ),(2,1,'x'),(0,2, _ ),(1,2, _ ),(2,2,'x')] -> Left "ERROR: Game already over."
        [(0,0, 'x'),(1,0, _ ),(2,0, _ ),(0,1, _ ),(1,1,'x'),(2,1, _ ),(0,2, _ ),(1,2, _ ),(2,2,'x')] -> Left "ERROR: Game already over."
        [(0,0,  _ ),(1,0, _ ),(2,0,'x'),(0,1, _ ),(1,1,'x'),(2,1, _ ),(0,2,'x'),(1,2, _ ),(2,2, _ )] -> Left "ERROR: Game already over."
        _ -> Right matrix
