const STEP_COUNT_P2 = 40;

/**
 * Tokenize the polymer
 * @param {string} polymer Polymer
 * @returns {{[string]: number}} Polymer tokenized
 */
function tokenizePolymer(polymer) {
    let map = {};
    let chars = polymer.split("");

    for (let i = 0; i < chars.length - 1; i++) {
        map[chars[i] + chars[i + 1]] = (map[chars[i] + chars[i + 1]] || 0) + 1;
    }

    return map;
}

/**
 * Step the second part
 * @param {{[string]: number}} polymerTokenized Polymer tokenized
 * @param {Pair[]} pairs Pairs
 * @returns {{[string]: number}} New tokenized polymer
 */
function step_P2(polymerTokenized, pairs) {
    let newPolymer = {};

    let keys = Object.keys(polymerTokenized);
    keys.forEach((polymerPair) => {
        let pair = pairs.find(p => p.pair === polymerPair);
        if (pair) {
            let left = pair.pair[0] + pair.insert;
            let right = pair.insert + pair.pair[1];

            newPolymer[left] = (newPolymer[left] || 0) + polymerTokenized[polymerPair];
            newPolymer[right] = (newPolymer[right] || 0) + polymerTokenized[polymerPair];
        }
    });

    return newPolymer;
}

/**
 * Part 2
 * @param {string} polymer Polymer
 * @param {Pair[]} pairs Pairs
 * @returns {number} Part 2 answer
 */
function part2(polymer, pairs) {
    console.log("Part 2:");

    let polymerTokenized = tokenizePolymer(polymer);

    for (let i = 0; i < STEP_COUNT_P2; ++i) {
        polymerTokenized = step_P2(polymerTokenized, pairs);
    }

    let charCount = {};
    Object.keys(polymerTokenized).forEach((key) => {
        charCount[key[0]] = (charCount[key[0]] || 0) + polymerTokenized[key];
    });

    charCount[polymer[polymer.length - 1]] = (charCount[polymer[polymer.length - 1]] || 0) + 1;

    let most = Object.keys(charCount).reduce((a, b) => charCount[a] > charCount[b] ? a : b);
    let least = Object.keys(charCount).reduce((a, b) => charCount[a] < charCount[b] ? a : b);

    return charCount[most] - charCount[least];
}

register(part2, "#part2");
