module Lesson2 where

l :: [Integer]
l = [1,2,3,4,54]

l2 :: [Integer]
l2 = 65 : l

l3 :: [Integer]
l3 = l ++ [1, 2]

e :: [a] -> Bool
e [] = True
e _ = False

atLeast2 :: [a] -> Bool
atLeast2 l' = 
  case l' of
    _ : _ : _ -> True
    _ -> False
    
len :: [a] -> Int
len [] = 0
len (_:xs) = 1 + len xs

len' :: [a] -> Int
len' a = len'' a 0
  where
    len'' :: [a] -> Int -> Int
    len'' [] acc = acc
    len'' (_:xs) acc = len'' xs (acc + 1)
    
incByOne :: [Integer] -> [Integer]
incByOne a = reverse $ incByOne' a []
  where
    incByOne' [] acc = acc
    incByOne' (x:xs) acc = incByOne' xs ( x + 1 : acc)
      
    