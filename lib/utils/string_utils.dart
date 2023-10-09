class StringUtils {
  static String getNoteTitleFromContent(String content) {
    final parts = content.split('\n');
    if (parts.isNotEmpty) {
      for (var part in parts) {
        if (part.isNotEmpty) {
          if (part.length > 80) {
            return part.substring(0, 80);
          }
          return part;
        }
      }
    }
    return '';
  }
}
