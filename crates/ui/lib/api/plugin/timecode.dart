import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/timecode.dart';
import 'package:mizer/protos/timecode.pb.dart';

class TimecodePluginApi implements TimecodeApi {
  final MethodChannel channel = const MethodChannel("mizer.live/timecode");

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

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
