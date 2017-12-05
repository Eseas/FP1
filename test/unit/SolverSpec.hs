module SolverSpec where

import Test.Hspec
import Solver
import Matrixer

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
    describe "solver" $ do
        it "Makes a move to the very first empty cell" $ do
            makeAMove Matrixer.indices
                `shouldBe` Just (0,0,'x')
        it "Solves notakto of 3 moves" $ do
            solve "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"
                `shouldBe` Right (Just (2,0,'x'))
        it "Finds problem in notakto of 3 moves" $ do
            solve "{\"c\": {\"0\":X1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"
                `shouldBe` Left "ERROR: Parsing Int failed. Must match: ('\"':_:'\"':':':' ':value:rest)."
        it "Detects wrong protocol in notakto of 5 moves" $ do
            solve "[\"c\", [2, 1], \"v\", \"x\", \"id\", \"kNPZxzgOeLfmdMbZsihoFs\"]"
                `shouldBe` Left "ERROR: Wrong protocol. rest = [\"c\", [2, 1], \"v\", \"x\", \"id\", \"kNPZxzgOeLfmdMbZsihoFs\"]"
        it "Solves notakto of 5 moves" $ do
            solve "{\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"gjTpfcCNvFIlewtwIKRrhiVtKEBqXL\", \"prev\": {\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"n\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"gjTpfcCNvFIlewtwIKRrhiVtKEBqXL\", \"prev\": {\"c\": {\"0\": 2, \"1\": 0}, \"v\": \"x\", \"id\": \"n\", \"prev\": {\"c\": {\"0\": 0, \"1\": 1}, \"v\": \"x\", \"id\": \"gjTpfcCNvFIlewtwIKRrhiVtKEBqXL\"}}}}}"
                `shouldBe` Right (Just (1,0,'x'))
        it "Does not fail crash with 0 moves" $ do
            solve "{}"
                `shouldBe` Right (Just (1,1,'x'))
        it "Detects multiple moves to a single cell" $ do
            solve "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"
                `shouldBe` Left "ERROR: One cell has multiple moves."
        it "Detects if game is already over by horizontal 3 Xs" $ do
            solve "{\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"vtQTlBGwpWtDfAIAZzvXeTz\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"QgBqKtNeXvKsltPYBVydEYM\", \"prev\": {\"c\": {\"0\": 1, \"1\": 0}, \"v\": \"x\", \"id\": \"vtQTlBGwpWtDfAIAZzvXeTz\", \"prev\": {\"c\": {\"0\": 0, \"1\": 2}, \"v\": \"x\", \"id\": \"QgBqKtNeXvKsltPYBVydEYM\", \"prev\": {\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"vtQTlBGwpWtDfAIAZzvXeTz\"}}}}}"
                `shouldBe` Left "ERROR: Game already over."
        it "Detects if game is already over by diagonal 3 Xs" $ do
            solve "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"CqtLQ\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"QPsgRGPiqNoIYLsIzMaLwWLsZC\", \"prev\": {\"c\": {\"0\": 2, \"1\": 0}, \"v\": \"x\", \"id\": \"CqtLQ\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"QPsgRGPiqNoIYLsIzMaLwWLsZC\", \"prev\": {\"c\": {\"0\": 1, \"1\": 1}, \"v\": \"x\", \"id\": \"CqtLQ\"}}}}}"
                `shouldBe` Left "ERROR: Game already over."
