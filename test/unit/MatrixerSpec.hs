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
                (Matrixer.indices, (-1, -1, ' ')) `shouldBe` Right ([(0,0,' '),(1,0,' '),(2,0,' '),(0,1,' '),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,'x'),(2,2,'x')], (1,2,'x'))
        it "Finds if cell is already occupied" $ do
          checkIfFreeAndInside  [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,'x'),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')] (0,1,'x')
                `shouldBe` Left "Occupied"
        it "Finds if cell is free" $ do
          checkIfFreeAndInside  [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,'x'),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')] (1,0,'x')
                `shouldBe` Right (1,0,'x')
        it "Finds position correctly" $ do
          position  (0,1,'x') [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,'x'),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')]
                `shouldBe` 3
        it "Does not find non existing element" $ do
          position  (1,1,'x') [(0,0,' '),(1,0,' '),(2,0,' '),(0,1,'x'),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,' ')]
                `shouldBe` -1
        it "Determines whether the game would be over on bad move" $ do
          checkGameOverOnMove  [(0,0,'x'),(1,0,' '),(2,0,' '),(0,1,' '),(1,1,' '),(2,1,' '),(0,2,' '),(1,2,' '),(2,2,'x')] (1,1,'x')
                `shouldBe` Left "ERROR: Game already over."
