module Main where

import Parser
import Solver

main :: IO ()
main = putStrLn m
  where
    -- m = "{\"c\": {\"0\": 1, \"1\": 2}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\", \"prev\": {\"c\": {\"0\": 2, \"1\": 2}, \"v\": \"x\", \"id\": \"FLwNCvOVREEuQhWEMALIgzWo\", \"prev\": {\"c\": {\"0\": 0, \"1\": 0}, \"v\": \"x\", \"id\": \"kbZzVrRPwiHsPkpQUUqpnkK\"}}}"
    m = Solver.m
