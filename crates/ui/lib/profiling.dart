T stopwatch<T>(String name, T Function() inner) {
  var before = DateTime.now();
  var result = inner();
  var after = DateTime.now();

  var duration = after.difference(before);
  var prettyDuration;
  if (duration.inMilliseconds > 1) {
    prettyDuration = "${duration.inMilliseconds}ms";
  }else {
    prettyDuration = "${duration.inMicroseconds}μs";
  }
  print("[Stopwatch] $name took $prettyDuration");

  return result;
}

Future<T> asyncStopwatch<T>(String name, Future<T> Function() inner) async {
  var before = DateTime.now();
  var result = await inner();
  var after = DateTime.now();

  var duration = after.difference(before);
  var prettyDuration;
  if (duration.inMilliseconds > 1) {
    prettyDuration = "${duration.inMilliseconds}ms";
  }else {
    prettyDuration = "${duration.inMicroseconds}μs";
  }
  print("[Stopwatch] $name took $prettyDuration");

  return result;
}
