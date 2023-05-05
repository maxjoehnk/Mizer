extension DoubleExtensions on double {
  String toPercentage() {
    return "${(this * 100).toStringAsFixed(1)}%";
  }
}

extension TimeExtensions on num {
  String toTimeString() {
    var hours = (this / (60 * 60)).floor();
    var mins = ((this % (60 * 60)) / 60).floor();
    var secs = this - (mins * 60) - (hours * 60 * 60);

    var timestring = "${_pad(mins)}:${_pad(secs)}";
    if (hours > 0) {
      timestring = "${_pad(hours)}:$timestring}";
    }
    return timestring;
  }
}

String _pad(num number) {
  return number.toString().padLeft(2, "0");
}
