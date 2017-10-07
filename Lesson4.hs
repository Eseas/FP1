module Lesson4 where


data GesintuvoTipas = A | B | C
  deriving Show
data Single = Single

data Gesintuvas = Gesintuvas Integer GesintuvoTipas
  deriving Show

spray :: Gesintuvas -> Gesintuvas
spray (Gesintuvas talpa t) = Gesintuvas (talpa - 1) t

ges1 :: Gesintuvas
ges1 = Gesintuvas 10 C

data GeresnisGesintuvas = GeresnisGesintuvas {
    gesintuvasTalpa :: Integer
  , gesintuvasTipas :: GesintuvoTipas
} deriving Show

ges2 :: GeresnisGesintuvas
ges2 = GeresnisGesintuvas 3123 B

data Galbut a = TikraiTaip a | TikraiNe

instance Show a => Show (Galbut a) where
  show TikraiNe = "Nenenene"
  show (TikraiTaip a) = "Va: " ++ (show a)


max' :: [Int] -> Maybe Int
max' [] = Nothing
max' [a] = Just a
max' [a, b] = if a > b then Just a else Just b
max' _ = Nothing

data ErrCode = NotEnough | TooMany
  deriving Show

max2 :: [Int] -> Either ErrCode Int
max2 [] = Left NotEnough
max2 [a] = Right a
max2 [a, b] = Right $ if a > b then a else b
max2 _ = Left TooMany

data PrimitiveVal = PrimitiveInt Int
  | PrimitiveStr String
  | PrimitiveList [PrimitiveVal]
  | PrimitiveDict [(String, PrimitiveVal)]
