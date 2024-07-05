import 'package:flutter/services.dart';
import 'package:mizer/protos/ui.pb.dart';

import '../contracts/ui.dart';

class UiPluginApi implements UiApi {
  final EventChannel showDialogEvents = const EventChannel("mizer.live/ui/dialog/show");

  @override
  Stream<ShowDialog> dialogRequests() {
    return showDialogEvents.receiveBroadcastStream()
        .map((buffer) => ShowDialog.fromBuffer(_convertBuffer(buffer)));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
