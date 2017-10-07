module Lesson3 where

msg :: String
msg = "li42ei0ee"
msg2 = ""

parse :: String -> [Integer]
parse m = fst $ parseList m

parseList :: String -> ([Integer], String)
parseList ('l':'e':rest) = ([], rest)
parseList ('l':t) = parseList' t []
  where
    parseList' :: String -> [Integer] -> ([Integer], String)
    parseList' ('e':rest) acc = (reverse acc, rest)
    parseList' m acc =
      let
        (r, rest) = parseInt m
        in parseList' rest (r : acc)
parseList _ = error "List expected"

parseInt :: String -> (Integer, String)
parseInt ('i':rest) =
  let
    iAsStr = takeWhile (/= 'e') rest
    strLenght = length iAsStr + 1
    rest1 = drop strLenght rest
    in (read iAsStr, rest1)
parseInt _ = error "Integer expected"

parseTwoLists :: String -> ([ [Integer] ], String)
parseTwoLists ('l':'e':rest) = ([], rest)
parseTwoLists ('l': rest) =
  let
    (l1, rest1) = parseList rest
    (l2, rest2) = parseList rest1
    in ([l1, l2], rest2)
parseTwoLists _ = error "Invalid two lists"
