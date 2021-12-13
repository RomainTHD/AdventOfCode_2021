/**
 * Part 2
 * @param grid Grid, where the 1st fold is already calculated
 * @return Nothing yet, WIP
 */
int part2(Grid grid) {
    while (grid.fold()) {}

    PrintWriter output = createWriter("answer");
    output.println(grid.toString());
    output.flush();
    output.close();

    // TODO: Return the answer
    return 0;
}
