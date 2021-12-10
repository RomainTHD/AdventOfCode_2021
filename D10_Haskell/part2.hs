module Part2 where
import Shared

import Data.List (sort, elemIndex)
import Shared (isOpeningChar)

-- Stack
newtype Stack a = Stack [a]
    deriving Show

-- Empty stack
emptyStack :: Stack a
emptyStack = Stack []

-- Empty stack ?
isEmpty :: Stack a -> Bool
isEmpty (Stack []) = True
isEmpty _ = False

-- Push an element to the stack
push :: a -> Stack a -> Stack a
push x (Stack xs) = Stack (x:xs)

-- Pop an element from the stack
pop :: Stack a -> (a, Stack a)
pop (Stack []) = error "Empty stack"
pop (Stack (x:xs)) = (x, Stack xs)

-- Peek the top element of the stack
peek :: Stack a -> a
peek (Stack []) = error "Empty stack"
peek (Stack (x:xs)) = x

-- Fill the stack from a string
fillStack :: String -> Stack Char -> Stack Char
fillStack "" s = s
fillStack (c:cs) s | isOpeningChar c = fillStack cs (push c s)
                   | otherwise = fillStack cs $ snd $ pop s

-- Complete a stack
completeStack :: Stack Char -> String
completeStack s | isEmpty s = ""
                | otherwise = closingChar (peek s) : completeStack (snd (pop s))

-- Complete a line
completeLine :: String -> String
completeLine line = completeStack (fillStack line emptyStack)

-- Ugly fix 1 because checkLine doesn't work lol
isLineOk1 :: String -> Bool
isLineOk1 (c1:c2:cs) | isOpeningChar c1 && isOpeningChar c2 = isLineOk1 (c2:cs)
                     | isOpeningChar c1 = (closingChar c1 == c2) && isLineOk1 (c2:cs)
                     | otherwise = isLineOk1 (c2:cs)
isLineOk1 _ = True

-- Ugly fix B because checkLine doesn't work lol
isLineOk2 :: String -> Bool
isLineOk2 s = all (\p -> check p s >= 0) punctuations
    where check (p1, p2) (c:cs) = check (p1, p2) cs + score c (p1, p2)
          check _        _      = 0
          score c (p1, p2) | c == p1 = 1
                           | c == p2 = -1
                           | otherwise = 0

-- Returns the score of a missong character
scoreMissingCharacter :: Char -> Int
scoreMissingCharacter ')' = 1
scoreMissingCharacter ']' = 2
scoreMissingCharacter '}' = 3
scoreMissingCharacter '>' = 4
scoreMissingCharacter _   = error "Unknown character "

-- Returns the score of a completed line
calcScore :: String -> Int
calcScore "" = 0
calcScore (c:cs) = scoreMissingCharacter c + 5 * calcScore cs

-- Part 2
part2 :: [String] -> IO Int
part2 lines = do
    let incompleteLines = filter (\line -> isLineOk1 line && isLineOk2 line && getFirstInvalidCharacter line /= lineOk) lines
    let values = map (calcScore . reverse . completeLine) incompleteLines
    let values2 = sort values
    print $ values2
    print $ length values2
    return $ values2 !! (length values2 `div` 2)

-- 2182912364
