/**
 * The number of steps to do
 */
const val STEPS = 100

/**
 * Part 1
 * @param gridInit The initial data
 * @return Part 1 answer
 */
fun part1(gridInit: Grid): Int {
    val data = clone(gridInit)
    var flashes = 0

    for (step in 1 until STEPS + 1) {
        flashes += step(data)
    }

    return flashes
}
