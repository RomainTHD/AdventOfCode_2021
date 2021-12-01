package main

import (
    "fmt"
)

// countIncreases1 count the increases for the 1st part of the challenge
func countIncreases1(lines []int) int {
    var count = 0
    var prev = lines[0] // Shouldn't raise any error since the array cannot be empty
    for i := 1; i < len(lines); i++ {
        var elt = lines[i]
        if prev < elt {
            count++
        }

        prev = elt
    }

    return count
}

// part1 executes the 1st part of the challenge
func part1() {
    var linesStr = readContent("./input")
    var lines = parseLines(linesStr)
    var nbInc = countIncreases1(lines)
    fmt.Println(nbInc)
}
