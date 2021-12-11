/**
 * Part 2
 * @param gridInit The initial data
 * @return Part 2 answer
 */
fun part2(gridInit: Grid): Int {
    val data = clone(gridInit)
    var stepCount = 0

    while (true) {
        val flashes = step(data)
        stepCount++

        if (flashes == gridInit.size * gridInit[0].size) {
            return stepCount
        }
    }
}
