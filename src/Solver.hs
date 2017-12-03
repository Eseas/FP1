module Solver where

import Parser
import Matrixer

solve :: String -> Either String (Maybe (Int, Int, Char))
solve msg =
    case createMove msg of
        Right (move, rest) ->
            case Matrixer.fillMatrix move (Matrixer.indices, (-1, -1, ' ')) of
                Right (matrix, lastMove) ->
                    case checkGameOver matrix of
                        Right matrix1 ->
                            case makeAMove2 (matrix, lastMove) of
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

makeAMove2 :: ([(Int, Int, Char)], (Int, Int, Char)) -> Maybe (Int, Int, Char)
makeAMove2 (matrix, (lx, ly, lsym)) =
  case checkIfFreeAndInside matrix (lx + 1, ly + 2, lsym) of
    Right (x, y, lsym) -> Just (x,y,lsym)
    Left e -> case checkIfFreeAndInside matrix (lx + 2, ly + 1, lsym) of
      Right (x, y, lsym) -> Just (x,y,lsym)
      Left e -> case checkIfFreeAndInside matrix (lx - 1, ly + 2, lsym) of
              Right (x, y, lsym) -> Just (x,y,lsym)
              Left e -> case checkIfFreeAndInside matrix (lx - 2, ly + 1, lsym) of
                      Right (x, y, lsym) -> Just (x,y,lsym)
                      Left e -> case checkIfFreeAndInside matrix (lx - 2, ly - 1, lsym) of
                              Right (x, y, lsym) -> Just (x,y,lsym)
                              Left e -> case checkIfFreeAndInside matrix (lx - 1, ly - 2, lsym) of
                                      Right (x, y, lsym) -> Just (x,y,lsym)
                                      Left e -> case checkIfFreeAndInside matrix (lx + 1, ly - 2, lsym) of
                                              Right (x, y, lsym) -> Just (x,y,lsym)
                                              Left e -> case makeAMoveWhereNoLoss matrix matrix of
                                                      Just (x, y, sym) -> Just (x, y, sym)
                                                      Nothing -> makeAMove matrix

makeAMoveWhereNoLoss :: [(Int, Int, Char)] -> [(Int, Int, Char)] -> Maybe (Int, Int, Char)
makeAMoveWhereNoLoss [] matrix = Nothing
makeAMoveWhereNoLoss (elem:restElem) matrix =
    case elem of
        (x, y, ' ') ->
          case position (x, y, ' ') matrix of
            -1 -> Nothing
            idx ->
              case checkGameOver newAcc of
                Right newAcc -> Just (x, y, 'x')
                Left e -> makeAMoveWhereNoLoss restElem matrix
              where
                newAcc = changeElement idx (x,y, 'x') matrix
        (x, y, 'x') -> makeAMoveWhereNoLoss restElem matrix
