/++
 + Load the file content
 + Returns: Content as an array of numbers
 +/
int[] loadContent() {
    import std.file : readText;
    import std.array;
    import std.conv : parse;

    const string filename = "./input";
    string content = readText(filename);
    string[] nbs = content.split(",");

    int[] res = new int[nbs.length];

    foreach (i, elt ; nbs) {
        res[i] = parse!int(elt);
    }

    return res;
}

/++
 + Finds the lowest amount of fuel to spend
 + Params: cost = a function to get the cost (possibly signed) between a crab and a target
 + Returns: The final minimal fuel spent
 +/
int calcMinFuel(int function(int, int) cost) {
    import std.array;
    import std.stdio : writeln;
    import std.math : abs;

    int[] crabs = loadContent();

    // Search bounds, every value above or under will be a worse solution
    int min = crabs[0];
    int max = crabs[0];
    foreach (crab ; crabs) {
        if (crab < min) {
            min = crab;
        }

        if (crab > max) {
            max = crab;
        }
    }

    // signed 32 bits max value
    int minFuel = 0x7fffffff;
    for (int dst = min; dst <= max; ++dst) {
        int fuel = 0;
        foreach (crab ; crabs) {
            fuel += abs(cost(crab, dst));
        }

        if (fuel < minFuel) {
            minFuel = fuel;
        }
    }

    return minFuel;
}
