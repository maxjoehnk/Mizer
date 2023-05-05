import 'dart:developer';

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
  log("[Stopwatch] $name took $prettyDuration");

  return result;
}
