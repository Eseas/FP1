module Solver where

import Parser
import Matrixer

solve :: String -> Either String (Maybe (Int, Int, Char))
solve msg =
    case createMove msg of
        Right (move, rest) ->
            case Matrixer.fillMatrix move Matrixer.indices of
                Right matrix ->
                    case checkGameOver matrix of
                        Right matrix1 ->
                            case makeAMove matrix of
                                Nothing ->
                                    Right Nothing
                                Just matrixMove ->
                                    Right (Just matrixMove)
                        Left errorMsg ->
                            Left errorMsg
                Left errorMsg ->
                    Left errorMsg

                -- matrix = Matrixer.fillMatrix move Matrixer.indices
        Left errorMsg ->
            Left errorMsg

makeAMove :: [(Int, Int, Char)] -> Maybe (Int, Int, Char)
makeAMove [] = Nothing
makeAMove (elem:restElem) =
    case elem of
        (x, y, ' ') -> Just (x, y, 'x')
        _ -> makeAMove restElem

makeAMove2 matrix (lx, ly, 'x')
  case uzimtasOrOutside(lx + 1, ly + 2) of
    Right (x, y, 'x') -> Just (x,y,'x')
    Left e -> case checkIfFreeAndInside(lx + 2, ly + 1) of
      Right (x, y, 'x') -> Just (x,y,'x')
      Left e -> case uzimtasOrOutside(lx - 1, ly + 2) of
              Right (x, y, 'x') -> Just (x,y,'x')
              Left e -> case uzimtasOrOutside(lx - 2, ly + 1) of
                      Right (x, y, 'x') -> Just (x,y,'x')
                      Left e -> case uzimtasOrOutside(lx - 2, ly - 1) of
                              Right (x, y, 'x') -> Just (x,y,'x')
                              Left e -> case uzimtasOrOutside(lx - 1, ly - 2) of
                                      Right (x, y, 'x') -> Just (x,y,'x')
                                      Left e -> makeAMoveWhereNoLoss
                                              no
                                              yes -> "Javla"

checkIfFreeAndInside :: [(Int, Int, Char)] -> Either String (Int, Int, Char)
checkIfFreeAndInside matrix (x, y, sym)
  | (x <= 2) && (x >= 0) && (y <= 2) && (y >= 0) = Left "Outside"
  | otherwise = case position (x, y, sym) matrix
                  -1 -> Left "Occupied"
                  _ -> Right (x, y, sym)

makeAMoveWhereNoLoss :: [(Int, Int, Char)] -> [(Int, Int, Char)] -> Maybe (Int, Int, Char)
makeAMove [] matrix = Nothing
makeAMoveWhereNoLoss (elem:restElem) matrix =
    case elem of
        (x, y, ' ') ->
          case position (x, y, ' ') matrix of
            -1 -> Nothing
            idx ->
              newAcc = changeElement idx (x,y, 'x') matrix
              case checkGameOver matrix of
                Right matrix -> Just (x, y, 'x')
                Left e -> makeAMoveWhereNoLoss restElem matrix
        (x, y, 'x') -> makeAMoveWhereNoLoss restElem matrix
