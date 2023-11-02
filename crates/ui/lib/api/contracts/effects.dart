import 'package:mizer/protos/effects.pb.dart';

export 'package:mizer/protos/effects.pb.dart';

abstract class EffectsApi {
  Future<List<Effect>> getEffects();
  Future<void> addEffect(String name);
  Future<void> deleteEffect(int id);
  Future<void> addEffectChannel(int id, EffectControl control);
  Future<void> removeEffectChannel(int id, int channelIndex);
  Future<void> addEffectStep(int id, int channelIndex, EffectStep step);
  Future<void> updateEffectStep(UpdateEffectStepRequest updateEffectStepRequest);
  Future<void> removeEffectStep(int id, int channelIndex, int stepIndex);
}
