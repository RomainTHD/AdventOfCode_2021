/++
 + Part 2
 + Returns: Part 2 result
 +/
int part2() {
    import utils;
    // Use the fact that sum(0, n) = n * (n +- 1) / 2
    return utils.calcMinFuel((int a, int b) => (b - a + (b < a ? -1 : 1)) * (b - a) / 2);
}
