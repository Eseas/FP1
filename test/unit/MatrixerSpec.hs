module MatrixerSpec where

import Test.Hspec
import Matrixer

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
  describe "strip" $ do
    it "removes leading and trailing whitespace" $ do
      Matrixer.indices `shouldBe` [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,' '),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')]
