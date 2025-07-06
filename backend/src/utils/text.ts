export function words_limit(input, x, options = {}) {
    // Default options
    const {
        appendEllipsis = false,  // Add "..." if string was truncated
        preservePunctuation = true,  // Keep punctuation attached to words
        strictWordCount = false  // Count hyphenated words as one word
    } = options;

    // Validation
    if (!input || typeof input !== 'string' || x <= 0) return '';

    // Split into words with different strategies
    let words;
    if (preservePunctuation) {
        words = input.trim().match(/(\S+)\s*/g) || [];
    } else {
        words = input.trim().split(/\s+/) || [];
    }

    // Handle hyphenated words if strictWordCount is true
    if (strictWordCount) {
        words = words.slice(0, x);
    } else {
        // Count each hyphenated part as separate words
        let count = 0;
        words = words.filter(word => {
            if (count >= x) return false;
            const subWords = word.split(/[-\/]/);
            count += subWords.length;
            return true;
        });
    }

    // Join the words
    let result = words.join(' ').trim();

    // Add ellipsis if needed
    if (appendEllipsis && input.trim().split(/\s+/).length > x) {
        result += '...';
    }

    return result;
}