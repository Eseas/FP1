module Entities (Point(..), Move(..)) where

data Point = Point { x :: Int
                   , y :: Int
                   } deriving (Show, Eq)

data Move = Empty | Move { point  :: Point
                         , symbol :: Char
                         , id     :: String
                         , prev   :: Move
                         } deriving (Show, Eq)
