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
