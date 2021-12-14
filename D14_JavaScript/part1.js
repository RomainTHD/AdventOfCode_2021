const STEP_COUNT_P1 = 10;

/**
 * Step the first part
 * @param {string} polymer Polymer
 * @param {Pair[]} pairs Pairs
 * @returns {string} New polymer
 */
function step_P1(polymer, pairs) {
    let newPolymer = "";

    for (let i = 0; i < polymer.length - 1; ++i) {
        let pairPolymer = polymer[i] + polymer[i + 1];
        let pair = pairs.find((p) => p.pair === pairPolymer);
        newPolymer += polymer[i] + (pair ? pair.insert : "");
    }

    newPolymer += polymer[polymer.length - 1];
    return newPolymer;
}

/**
 * Part 1
 * @param {string} polymer Polymer
 * @param {Pair[]} pairs Pairs
 * @returns {number} Part 1 answer
 */
function part1(polymer, pairs) {
    console.log("Part 1:");

    for (let i = 0; i < STEP_COUNT_P1; ++i) {
        polymer = step_P1(polymer, pairs);
    }

    let polymerArr = polymer.split("");

    let map = {};
    polymerArr.forEach((c) => {
        map[c] = (map[c] || 0) + 1;
    });

    let most = Object.keys(map).reduce((a, b) => map[a] > map[b] ? a : b);
    let least = Object.keys(map).reduce((a, b) => map[a] < map[b] ? a : b);

    return polymerArr.filter((c) => c === most).length - polymerArr.filter((c) => c === least).length;
}

register(part1, "#part1");
