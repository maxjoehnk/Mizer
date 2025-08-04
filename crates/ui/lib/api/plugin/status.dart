import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/api/plugin/ffi/status.dart';

import 'package:mizer/api/plugin/ffi/api.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart' show FFIBindings;

class StatusPluginApi implements StatusApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/status");
  final EventChannel statusEvents = const EventChannel("mizer.live/status/watch");

  StatusPluginApi(this.bindings);

  @override
  Future<StatusPointer?> getStatusPointer() async {
    int pointer = await channel.invokeMethod("getStatusPointer");

    return this.bindings.openStatus(pointer);
  }

  @override
  Stream<String?> getStatusMessages() {
    return statusEvents.receiveBroadcastStream().map((buffer) {
      return buffer as String?;
    });
  }
}
