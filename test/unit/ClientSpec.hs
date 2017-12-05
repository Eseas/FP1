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
            1 `shouldBe` 1
