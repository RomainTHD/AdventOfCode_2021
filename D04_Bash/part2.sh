#!/bin/bash

: "${bingoNumbers:?Variable not set or empty}"
: "${boardsCount:?Variable not set or empty}"
: "${boardRows:?Variable not set or empty}"
: "${boardCols:?Variable not set or empty}"
: "${retVal:?Variable not set or empty}"

# Part 2
function part2() {
    # Remove the spellcheck warning SC2154
    : "${boards[0, 0, 0]}"
    : "${isMarked[0, 0, 0]}"

    local boardWon
    for ((board = 0; board < boardsCount; board++)); do
        boardWon[board]=0
    done
    resetMarked

    local lastWinningBoard
    local lastNumber
    for number in "${bingoNumbers[@]}"; do
        for ((board = 0; board < boardsCount; board++)); do
            if [ "${boardWon[$board]}" -eq 1 ]; then
                continue
            fi

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
                            lastWinningBoard=$board
                            lastNumber=$number
                            boardWon[$board]=1
                        fi
                    fi
                done
            done
        done
    done

    sumUnmarked "$lastWinningBoard"
    sum=retVal

    echo -n "Last number: $lastNumber, "
    echo -n "last winning board: $lastWinningBoard, "
    echo -n "sum: $sum, "
    echo "product: $((lastNumber * sum))"
}
