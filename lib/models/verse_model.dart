class Verse {
  final int id;
  final String verseKey; // e.g., "1:1"
  final String textUthmani;
  final String? transliteration; // Added
  final String? translationText; // Added

  Verse({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
    this.transliteration,
    this.translationText,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    // Assuming the API returns translations in a nested structure
    String? translationTextValue;
    if (json['translations'] != null &&
        (json['translations'] as List).isNotEmpty) {
      final firstTranslationData = json['translations'][0];
      if (firstTranslationData is Map<String, dynamic> &&
          firstTranslationData['text'] is String) {
        translationTextValue = firstTranslationData['text'] as String?;
      } else {
        // Handle cases where 'text' is missing or not a string, or firstTranslationData is not a map
        translationTextValue = null;
      }
    } else {
      translationTextValue = null; // No translations array or it's empty
    }

    String? verseTransliteration;
    if (json['words'] != null && (json['words'] as List).isNotEmpty) {
      verseTransliteration = (json['words'] as List)
          .map((word) {
            // The transliteration per word might be directly under 'text' or nested further e.g. word['transliteration']['text']
            // Checking for common structures.
            if (word['transliteration'] is String) {
              return word['transliteration'];
            } else if (word['transliteration'] is Map &&
                word['transliteration']['text'] is String) {
              return word['transliteration']['text'];
            }
            return ''; // Return empty string if transliteration for a word is not found or in unexpected format
          })
          .join(' '); // Join word transliterations with a space
    }

    return Verse(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      verseKey:
          json['verse_key'] as String? ?? '', // Default to empty string if null
      textUthmani:
          json['text_uthmani'] as String? ??
          '', // Default to empty string if null
      transliteration: verseTransliteration
          ?.trim(), // Assign concatenated transliteration
      translationText: translationTextValue,
    );
  }
}
