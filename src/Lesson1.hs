module Lesson1 where

i :: Int
i = 42

k :: Integer
k = 84737457345762354723547623

foo :: Integer -> Integer
foo a = a + a

boo :: Integer -> Integer -> Integer
boo a b = a + b

addOne :: Integer -> Integer
addOne a = boo 1 a

addOne1 :: Integer -> Integer
addOne1 = boo 1

zoo :: Integer -> (Integer -> Integer) -> Integer
zoo a f = f a

bar :: Integer
bar = foo k

my1 :: Integer
my1 =
  let f a = a + 45
      k = 55
  in f k

my2 :: Integer
my2 =
  f k
  where
    f a = a + 45
    k = 55

adult :: Integer -> Bool
adult a =
  if a >= 18
    then True
    else False

baby :: Integer -> Bool
baby 0 = True
baby 1 = True
baby 2 = True
baby _ = False

du :: (Integer, Integer, Bool)
du = (1, 2, False)

dudu :: (Integer, Integer, Bool) -> (Integer, Integer)
dudu t =
  case t of
    (a1, a2, True) -> (a1, a2)
    _ -> (0, 0)
