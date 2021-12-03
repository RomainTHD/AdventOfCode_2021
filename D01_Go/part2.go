package main

import (
    "fmt"
)

// countIncreases2 count the increases for the 2nd part of the challenge
func countIncreases2(lines []int) int {
    var count = 0
    var prev int
    for i := 0; i < len(lines) - 2; i++ {
        var elt = lines[i] + lines[i+1] + lines[i+2]

        if i == 0 {
            prev = elt
            continue
        }

        if prev < elt {
            count++
        }

        prev = elt
    }

    return count
}

// part2 executes the 2nd part of the challenge
func part2() {
    var linesStr = readContent("./input")
    var lines = parseLines(linesStr)
    var nbInc = countIncreases2(lines)
    fmt.Println(nbInc)
}
