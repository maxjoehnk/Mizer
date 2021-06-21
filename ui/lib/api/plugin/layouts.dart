import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';

class LayoutsPluginApi implements LayoutsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/layouts");

  @override
  Future<Layouts> getLayouts() async {
    var response = await channel.invokeMethod("getLayouts");

    return Layouts.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<Layouts> addLayout(String name) async {
    var response = await channel.invokeMethod("addLayout", name);

    return Layouts.fromBuffer(_convertBuffer(response));
  }
}
