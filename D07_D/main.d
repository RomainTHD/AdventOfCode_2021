module d07;

/++
 + Main function
 +/
void main() {
    import std.stdio, std.format;
    import part1;
    import part2;

    "Part 1:".writeln;
    long r1 = part1.part1();
    "%s".format(r1).writeln;

    "Part 2:".writeln;
    long r2 = part2.part2();
    "%s".format(r2).writeln;
}
