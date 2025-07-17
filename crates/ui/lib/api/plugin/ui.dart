import 'package:flutter/services.dart';
import 'package:mizer/protos/ui.pb.dart';

import '../contracts/ui.dart';

class UiPluginApi implements UiApi {
  final MethodChannel channel = const MethodChannel("mizer.live/ui");
  final EventChannel showDialogEvents = const EventChannel("mizer.live/ui/dialog/show");

  @override
  Stream<ShowDialog> dialogRequests() {
    return showDialogEvents
        .receiveBroadcastStream()
        .map((buffer) => ShowDialog.fromBuffer(_convertBuffer(buffer)));
  }

  @override
  Future<TabularData> showTable(String table, List<String> arguments) async {
    var response = await this.channel.invokeMethod("showTable", [table, arguments]);

    return TabularData.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> commandLineExecute(String command) {
    return this.channel.invokeMethod("commandLineExecute", command);
  }

  @override
  Future<List<View>> getViews() async {
    var response = await this.channel.invokeListMethod("getViews");

    return response!.map((b) => View.fromBuffer(_convertBuffer(b))).toList();
  }
}
