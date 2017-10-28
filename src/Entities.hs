module Entities (Point(..), Move(..)) where

data Point = Point (Int, Int)
  deriving Show

data Move = Empty | Move { point  :: Point
                         , symbol :: Char
                         , id     :: String
                         , prev   :: Move
                         } deriving Show
