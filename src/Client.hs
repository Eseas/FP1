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
  makeGetRequest
  makePostRequest
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

makePostRequest :: IO ()
makePostRequest = do
  let request
            = setRequestMethod "POST"
            $ setRequestPath "/game/yolo84/player/2"
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Content-Type" ["application/json+map"]
            $ setRequestBodyLBS "{\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"Ljuss1\"}"
            $ defaultRequest
  response <- httpLBS request

  putStrLn $ "The status code was: " ++
             show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
  L8.putStrLn (getResponseBody response)

makeGetRequest :: IO ()
makeGetRequest = do
  --response <- httpLBS "http://httpbin.org/get"
  --response <- httpLBS "http://tictactoe.haskell.lt/game/yolo80/player/2"

  -- let request
  --           = setRequestPath "/get"
  --           $ setRequestHost "httpbin.org"
  --           $ defaultRequest
  -- response <- httpJSON request
  --
  -- putStrLn $ "The status code was: " ++
  --            show (getResponseStatusCode response)
  -- print $ getResponseHeader "Content-Type" response
  -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)

-- good
  let request
            = setRequestPath "/game/yolo82/player/2"
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Accept" ["application/json+map"]
            $ defaultRequest
  response <- httpLBS request

  putStrLn $ "The status code was: " ++
             show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
  L8.putStrLn (getResponseBody response)

 -- good
  -- let line = L8.unpack (getResponseBody response)
  -- putStrLn line
  -- case Solver.solve line of
  --   Left e -> putStrLn "Solve unsuccessful"
  --   Right e -> Just
  -- let solverMsg = Solver.solve line
  -- putStrLn solverMsg
-- end good

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
