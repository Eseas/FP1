module Lesson5 where

add :: Integer -> Integer -> Integer
add a b = a + b

data GesintuvoTipas = A | B | C
  deriving (Show)

data Gesintuvas = Gesintuvas Integer GesintuvoTipas
  deriving (Show)

instance Eq Gesintuvas where
  (==) (Gesintuvas t1 _) (Gesintuvas t2 _) = t1 == t2

instance Ord Gesintuvas where
  (<=) (Gesintuvas t1 _) (Gesintuvas t2 _) = t1 <= t2 

instance PliusMinusEq Gesintuvas where
  (.~.) (Gesintuvas t1 _) (Gesintuvas t2 _) = t1 .~. t2

class PliusMinusEq a where
  (.~.) :: a -> a -> Bool
  a .~. b = not (a /.~. b)
  (/.~.) :: a -> a -> Bool
  a /.~. b = not (a .~. b)

instance PliusMinusEq Integer where
  (.~.) a b = a - b < 2 && b - a < 3
