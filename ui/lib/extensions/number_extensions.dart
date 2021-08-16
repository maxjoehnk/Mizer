extension DoubleExtensions on double {
  String toPercentage() {
    return "${(this * 100).toStringAsFixed(1)}%";
  }
}
