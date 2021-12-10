module Part1 where

import Shared

-- Returns the score of a corrupted character
scoreCorruptedCharacter :: Char -> Int
scoreCorruptedCharacter ')' = 3
scoreCorruptedCharacter ']' = 57
scoreCorruptedCharacter '}' = 1197
scoreCorruptedCharacter '>' = 25137
scoreCorruptedCharacter _   = error "Unknown character "

-- Part 1
part1 :: [String] -> IO Int
part1 lines = do
    let illegalLines = filter (\line -> getFirstInvalidCharacter line `notElem` [lineOk, eol]) lines
    return $ sum . map (scoreCorruptedCharacter . getFirstInvalidCharacter) $ illegalLines
