module Shared where

-- Punctuation object
type Punctuation = (Char, Char)

-- Valid line
lineOk :: Char
lineOk = '\0'

-- Incomplete line
eol :: Char
eol = '\1'

-- Punctuation characters
punctuations :: [Punctuation]
punctuations = [('(', ')'), ('[', ']'), ('<', '>'), ('{', '}')]

-- Is a character a punctuation character ?
isOpeningChar :: Char -> Bool
isOpeningChar c = c `elem` map fst punctuations

-- Get the closing character of a punctuation
closingChar :: Char -> Char
closingChar c = snd $ head $ filter (\(p1, _) -> p1 == c) punctuations

-- Check a line, utility function, returns the character or a flag and the character
-- FIXME: Use a monad like Maybe or State
checkLine :: String -> (Char, String)
checkLine "" = (lineOk, "")
checkLine (c:cs) | not (null startChars) = if matching then
                                               checkLine rest
                                           else
                                               if endChar == eol then
                                                   (eol, rest)
                                               else
                                                   (eol, [endChar])
                 | otherwise = (c, cs)
    where startChars = filter (\(p1, _) -> p1 == c) punctuations
          (endChar, rest) = checkLine cs
          matching = snd (head startChars) == endChar

-- Get the first invalid character, or lineOk if the line is valid, or eol if the line is incomplete
getFirstInvalidCharacter :: String -> Char
getFirstInvalidCharacter s | c == lineOk = lineOk
                           | c == eol && head str == lineOk = eol
                           | c == eol = head str
                           | otherwise = error "Unknown character"
    where (c, str) = checkLine s
