module Lesson6 where
data GesintuvoTipas = A | B | C | Unknown
  deriving (Show, Eq)
instance Monoid GesintuvoTipas where
  mempty = Unknown
  mappend Unknown a = a
  mappend a Unknown = a
  mappend a b
    | a == b = a
    | otherwise = Unknown
data Gesintuvas = Gesintuvas Integer GesintuvoTipas
  deriving (Show)
instance Monoid Gesintuvas where
  mempty = Gesintuvas 0 Unknown
  mappend (Gesintuvas talpa1 tipas1) (Gesintuvas talpa2 tipas2) =
    Gesintuvas (talpa1 + talpa2) (tipas1 `mappend` tipas2)
data P = P Int Int deriving (Show, Eq)
instance Monoid P where
  mempty = P 0 0
  mappend (P a b) (P c d)
    | b <= c    = P (a + c - b) d
    | otherwise = P a (d + b - c)
parse :: Char -> P
parse '(' = P 0 1
parse ')' = P 1 0
parse _ = mempty
balance :: String -> Bool
balance xs = foldMap parse xs == mempty