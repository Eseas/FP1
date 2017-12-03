module ClientSpec where

import Test.Hspec
import Client
import Entities

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
    describe "client" $ do
        it "makes a string from Move" $ do
            convertBackToString (Move (Point 1 2) 'x' "player1" (Move (Point 2 2) 'x' "player2" (Move (Point 0 0) 'x' "player1" Entities.Empty)))
                `shouldBe` "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"player1\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"player2\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"player1\"}}}"
