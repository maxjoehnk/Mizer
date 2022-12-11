import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/mappings.dart';
import 'package:mizer/protos/mappings.pb.dart';

class MappingsPluginApi implements MappingsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/mappings");

  @override
  Future<void> addMapping(MappingRequest request) async {
    await channel.invokeMethod("addMapping", request.writeToBuffer());
  }
}
