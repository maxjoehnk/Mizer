import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/effects.dart';

class EffectsPluginApi implements EffectsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/effects");

  @override
  Future<List<Effect>> getEffects() async {
    var response = await channel.invokeMethod("getEffects");

    return _parseResponse(response).effects;
  }

  Future<void> addEffect(String name) async {
    await channel.invokeMethod("addEffect", name);
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

  @override
  Future<void> updateEffectStep(UpdateEffectStepRequest request) async {
    await channel.invokeMethod("updateEffectStep", request.writeToBuffer());
  }

  @override
  Future<void> addEffectChannel(int id, String fixtureChannel) async {
    var request = new AddEffectChannelRequest(effectId: id, fixtureChannel: fixtureChannel);
    await channel.invokeMethod("addEffectChannel", request.writeToBuffer());
  }

  @override
  Future<void> addEffectStep(int id, int channelIndex, EffectStep step) async {
    var request = new AddEffectStepRequest(effectId: id, channelIndex: channelIndex, step: step);
    await channel.invokeMethod("addEffectStep", request.writeToBuffer());
  }

  @override
  Future<void> removeEffectChannel(int id, int channelIndex) async {
    var request = new DeleteEffectChannelRequest(effectId: id, channelIndex: channelIndex);
    await channel.invokeMethod("deleteEffectChannel", request.writeToBuffer());
  }

  @override
  Future<void> removeEffectStep(int id, int channelIndex, int stepIndex) async {
    var request =
        new DeleteEffectStepRequest(effectId: id, channelIndex: channelIndex, stepIndex: stepIndex);
    await channel.invokeMethod("deleteEffectStep", request.writeToBuffer());
  }
}
