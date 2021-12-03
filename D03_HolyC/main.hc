#include "shared.hc"
#include "part1.hc"
#include "part2.hc"

/**
 * Main entry point
 * @return Exit code
 */
I32 main() {
    Words* words = createWords();
    "Part 1\n";
    part1(words);
    "Part 2\n";
    part2(words);
    freeWords(words);
    return 0;
}

Exit(main());
