module ParserSpec where

import Test.Hspec
import Parser
import Entities

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
  describe "parser" $ do
    it "parses single integer value" $ do
       Parser.parseInt2 "\"0\": 1, \"1\": 2}" `shouldBe` Right (1, ", \"1\": 2}")
    it "recognises wrong format" $ do
       Parser.parseInt2 "\"0\":11, \"1\": 2}" `shouldBe` Left "parseInt failed. Must match: '\"':_:'\"':':':' ':value:rest"
    it "can escalete error" $ do
      (Parser.turboParse2' "\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\"" (Move (Point (0,0)) 'X' "id" Entities.Empty)) `shouldBe` Left "Fuck"
    it "new algorithm works" $ do
      (parse "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\"" (Move (Point (0,0)) 'e' "id" Entities.Empty))
      `shouldBe` Right ((Move (Point (1,2)) 'x' "kbZzVrRPwiHsPkpQUUqpnkK" (Move (Point (2,2)) 'x' "FLwNCvOVREEuQhWEMALIgzWo" Entities.Empty)), "")
