class LineSorter {
  static List<String> sortLines(List<String> lines, bool ascending) {
    final sortedLines = List<String>.from(lines);
    sortedLines.sort((a, b) {
      if (ascending) {
        return a.compareTo(b);
      } else {
        return b.compareTo(a);
      }
    });
    return sortedLines;
  }

  static List<String> parseTextToLines(String text) {
    return text.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();
  }

  static String joinLinesToText(List<String> lines) {
    return lines.join('\n');
  }
}
