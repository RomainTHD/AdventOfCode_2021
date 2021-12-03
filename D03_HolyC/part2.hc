/**
 * Select the oxygen rating
 */
#define RATING_OXYGEN 0

/**
 * Select the CO2 rating
 */
#define RATING_CO2 1

/**
 *
 * @param words List of words
 * @param leastCommon Rating mode, see the macros above
 * @return Index in the word list, or -1
 */
U16 getRatingIndex(Words* words, Bool leastCommon) {
    // Words still available to search
    Bool* wordsAvailable = MAlloc(words->wordCount * sizeof(Bool));

    U16 i;
    for (i = 0; i < words->wordCount; ++i) {
        wordsAvailable[i] = 1;
    }

    // Index of the rating in the list of words
    U16 ratingIndex = -1;

    U8 j;
    for (j = 0; j < words->wordLength; ++j) {
        U16 count[2] = {0, 0};
        for (i = 0; i < words->wordCount; ++i) {
            if (wordsAvailable[i]) {
                ++count[words->words[i][j] - '0'];
            }
        }

        U8 mostOrLeastCommon = ((count[1] >= count[0]) ^ leastCommon) + '0';

        U16 availableCount = 0;
        for (i = 0; i < words->wordCount; ++i) {
            if (words->words[i][j] != mostOrLeastCommon) {
                wordsAvailable[i] = 0;
            }

            if (wordsAvailable[i]) {
                ++availableCount;
                ratingIndex = i;
            }
        }

        if (availableCount == 0) {
            "Error : no more values, leastCommon = %d\n", leastCommon;
            goto badEndFunction;
        }

        if (availableCount == 1) {
            goto endFunction;
        }
    }

    badEndFunction:
    ratingIndex = -1;

    endFunction:
    Free(wordsAvailable);
    return ratingIndex;
}

/**
 * Part 2
 * @param words List of words
 */
U0 part2(Words* words) {
    U16 oxygenRatingIndex = getRatingIndex(words, RATING_OXYGEN);
    U16 CO2RatingIndex = getRatingIndex(words, RATING_CO2);
    if (oxygenRatingIndex == -1 || CO2RatingIndex == -1) {
        Exit(1);
    }

    "Oxygen: %s\n", words->words[oxygenRatingIndex];
    "C02: %s\n", words->words[CO2RatingIndex];

    U16 oxygen = 0;
    U16 CO2 = 0;

    U16 i;
    for (i = 0; i < words->wordLength; ++i) {
        oxygen <<= 1;
        oxygen += words->words[oxygenRatingIndex][i] - '0';
        CO2 <<= 1;
        CO2 += words->words[CO2RatingIndex][i] - '0';
    }

    "Result: %d\n", oxygen * CO2;
}
