import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/timecode.dart';
import 'package:mizer/api/plugin/ffi/api.dart';
import 'package:mizer/api/plugin/ffi/timecode.dart';
import 'package:mizer/protos/timecode.pb.dart';

import 'ffi/bindings.dart' show FFIBindings;

class TimecodePluginApi implements TimecodeApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/timecode");
  final EventChannel changes = const EventChannel("mizer.live/timecode/watch");

  TimecodePluginApi(this.bindings);

  @override
  Future<void> addTimecode(AddTimecodeRequest request) async {
    await channel.invokeMethod("addTimecode", request.writeToBuffer());
  }

  @override
  Future<void> addTimecodeControl(AddTimecodeControlRequest request) async {
    await channel.invokeMethod("addTimecodeControl", request.writeToBuffer());
  }

  @override
  Future<void> deleteTimecode(DeleteTimecodeRequest request) async {
    await channel.invokeMethod("deleteTimecode", request.writeToBuffer());
  }

  @override
  Future<void> deleteTimecodeControl(DeleteTimecodeControlRequest request) async {
    await channel.invokeMethod("deleteTimecodeControl", request.writeToBuffer());
  }

  @override
  Future<AllTimecodes> getTimecodes() async {
    var response = await channel.invokeMethod("getTimecodes");

    return AllTimecodes.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> renameTimecode(RenameTimecodeRequest request) async {
    await channel.invokeMethod("renameTimecode", request.writeToBuffer());
  }

  @override
  Future<void> renameTimecodeControl(RenameTimecodeControlRequest request) async {
    await channel.invokeMethod("renameTimecodeControl", request.writeToBuffer());
  }

  @override
  Stream<AllTimecodes> watchTimecodes() {
    return changes.receiveBroadcastStream().map((buffer) {
      return AllTimecodes.fromBuffer(_convertBuffer(buffer));
    });
  }

  @override
  Future<TimecodePointer?> getTimecodePointer() async {
    int pointer = await channel.invokeMethod("getTimecodePointer");

    return this.bindings.openTimecode(pointer);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
