import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/api/plugin/ffi/status.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart' show FFIBindings;

class StatusPluginApi implements StatusApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/status");

  StatusPluginApi(this.bindings);

  @override
  Future<StatusPointer?> getStatusPointer() async {
    int pointer = await channel.invokeMethod("getStatusPointer");

    return this.bindings.openStatus(pointer);
  }
}
