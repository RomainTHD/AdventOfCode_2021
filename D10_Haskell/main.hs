module Main where

import Part1
import Part2

-- Load the file
loadContent :: String -> IO [String]
loadContent path = do
    content <- readFile path
    return $ lines content

-- Main
main :: IO()
main = do
    putStrLn "Part 1"
    lines <- loadContent "input2"
    r1 <- part1 lines
    print r1
    putStrLn "Part 2"
    r2 <- part2 lines
    print r2
    putStrLn "OK"
