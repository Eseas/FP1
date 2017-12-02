{-# LANGUAGE OverloadedStrings #-}
module Client where

import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.ByteString.Lazy.Char8 as L8
import qualified Data.Yaml             as Yaml
import Network.HTTP.Simple

makePostRequest :: IO ()
makePostRequest = do
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
  --         -- $ setRequestHeader "Accept" ["application/json+map"]
  --         -- $ setRequestPort 80
  -- response <- httpJSON request
  --
  -- putStrLn $ "The status code was: " ++
  --            show (getResponseStatusCode response)
-- end good

  --print $ getResponseHeader "Content-Type" response
  --L8.putStrLn $ getResponseBody response
