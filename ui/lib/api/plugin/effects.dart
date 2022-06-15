import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/effects.dart';

class EffectsPluginApi implements EffectsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/effects");

  @override
  Future<List<Effect>> getEffects() async {
    var response = await channel.invokeMethod("getEffects");

    return _parseResponse(response).effects;
  }


  @override
  Future<void> deleteEffect(int id) async {
    await channel.invokeMethod("deleteEffect", id);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  static Effects _parseResponse(List<Object> response) {
    return Effects.fromBuffer(_convertBuffer(response));
  }
}
