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
            Parser.parseInt "\"0\": 1, \"1\": 2}"
                `shouldBe` Right (1, ", \"1\": 2}")
        it "recognises wrong Int format" $ do
            Parser.parseInt "\"0\":11, \"1\": 2}"
                `shouldBe` Left "ERROR: Parsing Int failed. Must match: ('\"':_:'\"':':':' ':value:rest)."
        it "recognises wrong String format" $ do
            Parser.parseString "string"
                `shouldBe` Left "ERROR: Parsing String failed. Must match: ('\"':rest)."
        it "parses move of 0 X" $ do
            createMove "{}"
                `shouldBe` Right (Entities.Empty, "")
        it "parses move of 1 X" $ do
            createMove "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}"
                `shouldBe` Right ((Move (Point 1 2) 'x' "kbZzVrRPwiHsPkpQUUqpnkK" Entities.Empty), "")
        it "creates a move of 2 Xs" $ do
            createMove "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\"}}"
                `shouldBe` Right ((Move (Point 1 2) 'x' "kbZzVrRPwiHsPkpQUUqpnkK" (Move (Point 2 2) 'x' "FLwNCvOVREEuQhWEMALIgzWo" Entities.Empty)), "")
        -- it "creates a move of 2 Xs" $ do
        --     (createMove "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\"}}")
        --         `shouldBe` Right ((Move (Point (1,2)) 'x' "kbZzVrRPwiHsPkpQUUqpnkK" (Move (Point (2,2)) 'x' "FLwNCvOVREEuQhWEMALIgzWo" Entities.Empty)), "")
