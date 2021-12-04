#!/bin/bash

declare -x bingoNumbers=[]
declare -x boardsCount=0
declare -x boardRows=0
declare -x boardCols=0
declare -A boards=
declare -A isMarked=

# Hacky but works
declare -x retVal=0

# Loads the data from a file
#
# $1 - File path
function loadData() {
    local filepath=$1
    local dataStr
    dataStr=$(cat "$filepath")

    local lines
    readarray -t lines <<<"$dataStr"

    IFS=',' read -r -a bingoNumbers <<<"${lines[0]}"

    lines=("${lines[@]:2}")

    local row=0
    for line in "${lines[@]}"; do
        if [ "$line" == "" ]; then
            ((boardsCount += 1))
            boardRows=$((row > boardRows ? row : boardRows))
            row=0
        else
            local chars
            IFS=' ' read -r -a chars <<<"$line"

            local col=0
            for char in "${chars[@]}"; do
                boards[$boardsCount, $row, $col]="$char"
                ((col += 1))
            done
            boardCols=$((col > boardCols ? col : boardCols))

            ((row += 1))
        fi
    done

    # FIXME: Hack, will not work as expected if there are no boards
    ((boardsCount += 1))
}

# Prints the data, debug
function printData() {
    echo "Boards:$boardsCount"
    echo "Rows:$boardRows"
    echo "Cols:$boardCols"

    for ((board = 0; board < boardsCount; board++)); do
        for ((row = 0; row < boardRows; row++)); do
            for ((col = 0; col < boardCols; col++)); do
                echo -n "${boards[$board, $row, $col]} "
            done
            echo
        done
        echo
    done
}

# Sums the unmarked values
#
# $1 - Winning board index
function sumUnmarked() {
    local winningBoard=$1

    local sumUnmarked=0
    for ((row = 0; row < boardRows; row++)); do
        for ((col = 0; col < boardCols; col++)); do
            if [ "${isMarked[$winningBoard, $row, $col]}" -eq 0 ]; then
                ((sumUnmarked += boards[$winningBoard, $row, $col]))
            fi
        done
    done

    retVal=$sumUnmarked
}

# Reset the marked array
function resetMarked() {
    for ((board = 0; board < boardsCount; board++)); do
        for ((row = 0; row < boardRows; row++)); do
            for ((col = 0; col < boardCols; col++)); do
                isMarked[$board, $row, $col]=0
            done
        done
    done
}

# Main function
function main() {
    loadData "./input"
    source "part1.sh"
    source "part2.sh"
    part1
    part2
}

main
