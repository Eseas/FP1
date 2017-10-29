module MatrixerSpec where

import Test.Hspec
import Matrixer
import Entities

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
    describe "matrixer" $ do
        it "creates multidimension array" $ do
            Matrixer.indices `shouldBe` [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,' '),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')]
        it "fills matrix with two Xs" $ do
            fillMatrix (Move (Point (1,2)) 'x' "kbZzVrRPwiHsPkpQUUqpnkK" (Move (Point (2,2)) 'x' "FLwNCvOVREEuQhWEMALIgzWo" Entities.Empty))
                Matrixer.indices `shouldBe` Right [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,' '),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,'x'),(2,2,'x')]
