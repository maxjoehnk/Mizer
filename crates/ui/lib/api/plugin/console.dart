import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/console.dart';
import 'package:mizer/protos/console.pb.dart';

class ConsolePluginApi implements ConsoleApi {
  final MethodChannel channel = const MethodChannel("mizer.live/console");
  final EventChannel consoleEvents = const EventChannel("mizer.live/console/watch");

  @override
  Future<List<ConsoleMessage>> getHistory() async {
    var response = await channel.invokeMethod("getConsoleHistory");

    return _parseResponse(response).messages;
  }

  @override
  Stream<ConsoleMessage> stream() {
    return consoleEvents
        .receiveBroadcastStream()
        .map((buffer) => ConsoleMessage.fromBuffer(_convertBuffer(buffer)));
  }

  static ConsoleHistory _parseResponse(List<Object> response) {
    return ConsoleHistory.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
