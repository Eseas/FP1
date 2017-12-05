{-# LANGUAGE OverloadedStrings #-}
module Client where

import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.ByteString.Lazy.Char8 as L8
import qualified Data.Yaml             as Yaml
import Network.HTTP.Simple
import Solver
import Entities
import System.Console.ANSI

attack :: String -> String -> IO ()
attack gameName playerName = do
  putStrLn "~~~~~~~~~~~~~~~~~ GAME begin: ATTACK ~~~~~~~~~~~~~~~~~"
  run "attack" gameName playerName
  putStrLn "~~~~~~~~~~~~~~~~~ GAME over : ATTACK ~~~~~~~~~~~~~~~~~"

defend :: String -> String -> IO ()
defend gameName playerName = do
  putStrLn "~~~~~~~~~~~~~~~~~ GAME begin: DEFEND ~~~~~~~~~~~~~~~~~"
  run "defend" gameName playerName
  putStrLn "~~~~~~~~~~~~~~~~~ GAME begin: DEFEND ~~~~~~~~~~~~~~~~~"

run :: String -> String -> String -> IO ()
run mode gameName playerName = do
  origMsg <- case mode of
    "attack" -> return "{}"
    "defend" -> makeGetRequest gameName playerName
  case Solver.solve origMsg of
    Left "ERROR: Game already over." -> do
      setSGR [SetColor Foreground Vivid Green]
      putStrLn "Congratulations, Kazimieras robot won!"
      setSGR [Reset]
    Left errorMsg -> do
      setSGR [SetColor Foreground Vivid Red]
      putStrLn errorMsg
      setSGR [Reset]
    Right (Just (x,y,sym)) -> do
      makePostRequest newMsg gameName playerName
      run "defend" gameName playerName
      where
        newMsg = concatToMoveString origMsg (x,y,sym) playerName


concatToMoveString :: [Char] -> (Int, Int, Char) -> String -> [Char]
concatToMoveString oldMsg (x,y,sym) playerName =
  newMsg
  where
    newMsg = "{\"c\": {\"0\": " ++ show x ++ ", \"1\": " ++ show y ++ "}, \"v\": \"" ++ [sym] ++ "\", \"id\": \"" ++ playerName ++ "\"" ++ case oldMsg of
      "{}" -> "}"
      _ -> ", \"prev\": " ++ oldMsg ++ "}"

makePostRequest :: String -> String -> String -> IO (Either String String)
makePostRequest msg gameName playerName = do
  putStrLn "------------- POST begin -------------"
  let request
            = setRequestMethod "POST"
            $ setRequestPath (S8.pack ("/game/" ++ gameName ++ "/player/" ++ playerName))
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Content-Type" ["application/json+map"]
            $ setRequestBodyLBS (L8.pack (msg))
            $ defaultRequest
  response <- httpLBS request

  case (getResponseStatusCode response) of
    200 -> do
      setSGR [SetColor Foreground Vivid Green]
      putStrLn ("POST: status: " ++
             show (getResponseStatusCode response))
      setSGR [Reset]
    _ -> do
      setSGR [SetColor Foreground Vivid Red]
      putStrLn ("POST: status: " ++
             show (getResponseStatusCode response))
      setSGR [Reset]
  print $ getResponseHeader "Content-Type" response
  L8.putStrLn (getResponseBody response)
  putStrLn ("Message: " ++ msg)
  putStrLn "------------- POST end -------------\n"
  return (Right "ok")


makeGetRequest :: String -> String -> IO String
makeGetRequest gameName playerName = do
  putStrLn "------------- GET begin -------------"
  let request
            = setRequestPath (S8.pack ("/game/" ++ gameName ++ "/player/" ++ playerName))
            $ setRequestHost "tictactoe.haskell.lt"
            $ setRequestHeader "Accept" ["application/json+map"]
            $ defaultRequest
  response <- httpLBS request

  case (getResponseStatusCode response) of
    200 -> do
      setSGR [SetColor Foreground Vivid Green]
      putStrLn ("GET: status: " ++
             show (getResponseStatusCode response))
      setSGR [Reset]
    _ -> do
      setSGR [SetColor Foreground Vivid Red]
      putStrLn ("GET: status: " ++
             show (getResponseStatusCode response))
      setSGR [Reset]
  print $ getResponseHeader "Content-Type" response

  let line = L8.unpack (getResponseBody response)
  putStrLn ("Message: " ++ line)
  putStrLn "------------- GET end -------------\n"
  return line
