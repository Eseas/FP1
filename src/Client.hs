{-# LANGUAGE OverloadedStrings #-}
module Client where

import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.ByteString.Lazy.Char8 as L8
import qualified Data.Yaml             as Yaml
import Network.HTTP.Simple
import Solver
import Entities

defend :: String -> String -> IO ()
defend gameName playerName = do
  origMsg <- makeGetRequest
  makePostRequest origMsg
  --defend gameName playerName
  --return expression
  print "Done"

convertBackToString :: Move -> [Char]
convertBackToString Entities.Empty =
    "end"
convertBackToString move =
  newAcc
  where
      newAcc = "{\"c\": {\"0\": " ++ show (x (point move)) ++ ", \"1\": " ++ show (y (point move)) ++ "}, \"v\": \"" ++ [symbol move] ++ "\", \"id\": \"" ++ (Entities.id move) ++ "\"" ++       case prev move of
        Entities.Empty -> "}"
        _ -> ", \"prev\": " ++ convertBackToString (prev move) ++ "}"
      previousTurn = prev move

concatToMoveString :: [Char] -> (Int, Int, Char) -> String -> [Char]
concatToMoveString oldMsg (x,y,sym) playerName =
  newMsg
  where
    newMsg = "{\"c\": {\"0\": " ++ show x ++ ", \"1\": " ++ show y ++ "}, \"v\": \"" ++ [sym] ++ "\", \"id\": \"" ++ playerName ++ "\"" ++ ", \"prev\": " ++ oldMsg ++ "}"

makePostRequest :: String -> IO ()
makePostRequest origMsg = do
  case Solver.solve origMsg of
    Left e -> putStrLn "Solve unsuccessful"
    Right (Just (x,y,sym)) ->
      let request
            = setRequestMethod "POST"
            $ setRequestPath "/game/yolo84/player/2"
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Content-Type" ["application/json+map"]
            $ setRequestBodyLBS (concatToMoveString origMsg (x,y,sym) "2")
            $ defaultRequest
            response <- httpLBS request

  putStrLn $ "The status code was: " ++
             show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
  L8.putStrLn (getResponseBody response)


makeGetRequest :: IO String
makeGetRequest = do
  let request
            = setRequestPath "/game/yolo88/player/2"
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Accept" ["application/json+map"]
            $ defaultRequest
  response <- httpLBS request

  putStrLn $ "The status code was: " ++
             show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
  L8.putStrLn (getResponseBody response)

  let line = L8.unpack (getResponseBody response)
  putStrLn ("unpacked value: " ++ line)
  return line

  -- case getResponseStatusCode response of
  --   200 -> putStrLn "good answer"
  --   _ -> putStrLn "wrong answer"
  --         -- $ setRequestHeader "Accept" ["application/json+map"]
  --         -- $ setRequestPort 80
  -- response <- httpJSON request
  --
  -- putStrLn $ "The status code was: " ++
  --            show (getResponseStatusCode response)
-- end good

  --print $ getResponseHeader "Content-Type" response
  --L8.putStrLn $ getResponseBody response


  -- {"c": {"0": 1, "1": 1}, "v": "x", "id": "Ljuss2", "prev": {"c": {"0": 0, "1": 0}, "v": "x", "id": "Ljuss1"}}
