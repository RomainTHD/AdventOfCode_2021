#include "input"

/**
 * List of words
 */
class Words {
    /**
     * Words, list of strings
     */
    U8** words;

    /**
     * Length of each word
     */
    U8 wordLength;

    /**
     * Number of words
     */
    U16 wordCount;
};

/**
 * Create a list of words
 * @return List of words
 */
Words* createWords() {
    Words* words = MAlloc(sizeof(Words));

    words->wordLength = 0;
    words->wordCount = 0;

    U8 currentWordLength = 0;
    U8* c = input;
    while (*c != '\0') {
        // Initialize the wordCount field
        if (*c == '0' || *c == '1') {
            ++currentWordLength;
        } else {
            if (currentWordLength > words->wordLength) {
                words->wordLength = currentWordLength;
            }
            currentWordLength = 0;
            ++words->wordCount;
        }

        ++c;
    }

    words->words = MAlloc(words->wordCount * sizeof(U8 * ));
    words->words[0] = NULL;

    U8 charIdx = 0;
    U16 wordIdx = 0;

    c = input;
    while (*c != '\0') {
        // Initialize the words
        if (*c == '0' || *c == '1') {
            if (words->words[wordIdx] == NULL) {
                // See below
                words->words[wordIdx] = MAlloc(words->wordLength * sizeof(U8));
            }

            words->words[wordIdx][charIdx] = *c;
            ++charIdx;
        } else {
            charIdx = 0;
            ++wordIdx;
            if (wordIdx < words->wordCount) {
                // We don't want to allocate the memory here because we might be at the end of the list
                words->words[wordIdx] = NULL;
            }
        }

        ++c;
    }

    return words;
};

/**
 * Free the list of words
 * @param words List of words
 */
U0 freeWords(Words* words) {
    U16 i;
    for (i = 0; i < words->wordCount; ++i) {
        Free(words->words[i]);
    }

    Free(words);
}
