extension StringExtensions on String {
  String toCapitalCase() {
    return this.splitMapJoin(RegExp(r"[ +]"), onNonMatch: (match) {
      if (match.isEmpty) {
        return "";
      }
      return match.substring(0, 1).toUpperCase() + match.substring(1);
    });
  }
}
