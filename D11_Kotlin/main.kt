import java.io.File
import java.util.ArrayDeque

/**
 * World
 */
typealias Grid = Array<Array<Int>>

/**
 * Position
 */
typealias Position = Pair<Int, Int>

/**
 * Directions
 */
val DIRECTIONS = listOf(
    Pair(1, 0), Pair(1, 1), Pair(0, 1), Pair(-1, 1), Pair(-1, 0), Pair(-1, -1), Pair(0, -1), Pair(1, -1)
)

/**
 * Position already flashed
 */
const val ALREADY_FLASHED = -100

/**
 * Load the grid from the given file
 * @param fileName The file to load
 * @return Loaded grid
 */
fun loadData(fileName: String): Grid {
    val data = File(fileName).readLines()
    return Array(data.size) { row ->
        Array(data[row].length) { col ->
            data[row][col].code - '0'.code
        }
    }
}

/**
 * Clone the given grid
 * @param grid The grid to clone
 * @return Cloned grid
 */
fun clone(grid: Grid): Grid {
    return Array(grid.size) { row ->
        Array(grid[row].size) { col ->
            grid[row][col]
        }
    }
}

/**
 * Print the given grid
 * @param grid The grid to print
 */
fun printGrid(grid: Grid) {
    for (row in grid.indices) {
        for (col in grid[row].indices) {
            print(grid[row][col])
        }
        println()
    }
}

/**
 * Step the given grid
 * @param grid The grid to step
 * @return The number of flashes
 */
fun step(grid: Grid): Int {
    val toUpdate = ArrayDeque<Position>()
    var flashes = 0

    for (row in grid.indices) {
        for (col in grid[row].indices) {
            toUpdate.push(Position(row, col))
        }
    }

    while (toUpdate.size != 0) {
        val pos = toUpdate.pop()
        ++grid[pos.first][pos.second]

        if (grid[pos.first][pos.second] <= 9) {
            continue
        }

        grid[pos.first][pos.second] = ALREADY_FLASHED
        ++flashes

        for (dir in DIRECTIONS) {
            val posOffset = Position(pos.first + dir.first, pos.second + dir.second)
            if (posOffset.first in grid.indices && posOffset.second in grid[posOffset.first].indices) {
                if (grid[posOffset.first][posOffset.second] != ALREADY_FLASHED) {
                    toUpdate.push(posOffset)
                }
            }
        }
    }

    for (row in grid.indices) {
        for (col in grid[row].indices) {
            if (grid[row][col] < 0) {
                grid[row][col] = 0
            }
        }
    }

    return flashes
}

/**
 * Main
 * @param args Command line arguments
 */
fun main(args: Array<String>) {
    val data = loadData("input")
    println("Part 1:")
    println("${part1(data)}")
    println("Part 2:")
    println("${part2(data)}")
    println("OK")
}
