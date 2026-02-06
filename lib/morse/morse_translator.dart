class MorseTranslator {
  static const Map<String, String> _textToMorse = {
    'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.',
    'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
    'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---',
    'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
    'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--',
    'Z': '--..', '0': '-----', '1': '.----', '2': '..---',
    '3': '...--', '4': '....-', '5': '.....', '6': '-....',
    '7': '--...', '8': '---..', '9': '----.', ' ': '/',
    '.': '.-.-.-', ',': '--..--', '?': '..--..', '!': '-.-.--',
    ':': '---...', ';': '-.-.-.', '"': '.-..-.', '\'': '.----.',
    '(': '-.--.', ')': '-.--.-', '&': '.-...', '@': '.--.-.',
    '=': '-...-', '+': '.-.-.', '-': '-....-', '_': '..--.-',
    '\$': '...-..-', '%': '--------',
  };

  static final Map<String, String> _morseToText = {
    for (var entry in _textToMorse.entries) entry.value: entry.key,
  };

  static String textToMorse(String text) {
    final result = <String>[];
    for (final char in text.toUpperCase().split('')) {
      if (_textToMorse.containsKey(char)) {
        result.add(_textToMorse[char]!);
      }
    }
    return result.join(' ');
  }

  static String morseToText(String morse) {
    final result = <String>[];
    for (final code in morse.split(' ')) {
      if (_morseToText.containsKey(code)) {
        result.add(_morseToText[code]!);
      } else if (code.isEmpty) {
        result.add(' ');
      }
    }
    return result.join('');
  }

  static bool isValidMorse(String morse) {
    final codes = morse.split(' ');
    for (final code in codes) {
      if (code.isNotEmpty && !_morseToText.containsKey(code)) {
        return false;
      }
    }
    return true;
  }
}
