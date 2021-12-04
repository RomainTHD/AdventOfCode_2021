#!/bin/bash

: "${bingoNumbers:?Variable not set or empty}"
: "${boardsCount:?Variable not set or empty}"
: "${boardRows:?Variable not set or empty}"
: "${boardCols:?Variable not set or empty}"
: "${retVal:?Variable not set or empty}"

# FIXME: Not working ?
# : "${boards:?Variable not set or empty}"

# Part 1
function part1() {
    # Remove the spellcheck warning SC2154
    : "${boards[0, 0, 0]}"
    : "${isMarked[0, 0, 0]}"

    resetMarked

    local winningBoard
    local lastNumber
    for number in "${bingoNumbers[@]}"; do
        for ((board = 0; board < boardsCount; board++)); do
            for ((row = 0; row < boardRows; row++)); do
                for ((col = 0; col < boardCols; col++)); do
                    if [ "${boards[$board, $row, $col]}" -eq "$number" ]; then
                        isMarked[$board, $row, $col]=1

                        local rowCount=0
                        local colCount=0
                        # Warning, here it is assumed that boardRows == boardCols
                        for ((idx = 0; idx < boardRows; idx++)); do
                            ((rowCount += isMarked[$board, $idx, $col]))
                            ((colCount += isMarked[$board, $row, $idx]))
                        done

                        if [ "$rowCount" -eq "$boardRows" ] || [ "$colCount" -eq "$boardCols" ]; then
                            winningBoard=$board
                            lastNumber=$number
                            break 4
                        fi
                    fi
                done
            done
        done
    done

    sumUnmarked "$winningBoard"
    sum=retVal

    echo -n "Last number: $lastNumber, "
    echo -n "first winning board: $winningBoard, "
    echo -n "sum: $sum, "
    echo "product: $((lastNumber * sum))"
}
