/**
 * Part 1
 * @param grid Grid
 * @return Part 1 solution
 */
int part1(Grid grid) {
    grid.fold();
    return grid.size();
}
