/**
 * Part 1
 * @param words List of words
 */
U0 part1(Words* words) {
    // Count array, store the number of zeroes and ones
    I32* arr = MAlloc(words->wordLength * sizeof(I32));

    U32 i, j;
    for (i = 0; i < words->wordCount; ++i) {
        // Fill the count array
        for (j = 0; j < words->wordLength; ++j) {
            U8 c = words->words[i][j];
            if (c == '0') {
                --arr[j];
            } else if (c == '1') {
                ++arr[j];
            }
        }
    }

    U32 gamma = 0; // Most common byte
    U32 epsilon = 0; // Least common byte
    // FIXME: We could also define epsilon as ~gamma ?

    for (i = 0; i < words->wordLength; ++i) {
        U8 byte = arr[i] > 0;

        gamma <<= 1;
        gamma += byte;

        epsilon <<= 1;
        epsilon += byte ^ 0x01;
    }

    "Gamma: ";
    for (i = 0; i < words->wordLength; ++i) {
        "%d", arr[i] > 0;
    }
    "\n";

    "Epsilon: ";
    for (i = 0; i < words->wordLength; ++i) {
        "%d", arr[i] < 0;
    }
    "\n";

    "Result: %d\n", gamma * epsilon;

    Free(arr);
}
