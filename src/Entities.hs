{-# LANGUAGE OverloadedStrings #-}
module Entities (Point(..), Move(..)) where

import Data.Aeson

data Point = Point { x :: Int
                   , y :: Int
                   } deriving (Show, Eq)
instance ToJSON Point where
  toJSON (Point x y) = object
    [ "0" .= x
    , "1" .= y
    ]

data Move = Empty | Move { point  :: Point
                         , symbol :: Char
                         , id     :: String
                         , prev   :: Move
                         } deriving (Show, Eq)
instance ToJSON Move where
  toJSON (Move point symbol id prev) = object
    [ "c" .= point
    , "v" .= symbol
    , "id" .= id
    , "prev" .= prev
    ]

data GameState = GameState { iniMsg :: String
                           --,
                           }
