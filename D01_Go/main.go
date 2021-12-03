package main

import (
    "os"
    "strconv"
    "strings"
)

// check checks an error
func check(e error) {
    if e != nil {
        panic(e)
    }
}

// readContent reads the content of a file and split it to output a list of lines
func readContent(filename string) []string {
    var data, err = os.ReadFile(filename)
    check(err)
    var content = string(data)
    var lines = strings.Split(strings.ReplaceAll(content, "\r\n", "\n"), "\n")
    return lines
}

// parseLines parses the string lines to a list of numbers
func parseLines(lines []string) []int {
    var linesInt = make([]int, len(lines))
    for idx, line := range lines {
        if len(line) == 0 {
            continue
        }

        var n, err = strconv.Atoi(strings.TrimSpace(line))
        check(err)
        linesInt[idx] = n
    }

    if len(linesInt) == 0 {
        panic("Empty file")
    }

    return linesInt
}

// main is our entry point
func main() {
    part1()
    part2()
}
