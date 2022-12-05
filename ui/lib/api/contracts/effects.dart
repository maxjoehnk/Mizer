import 'package:mizer/protos/effects.pb.dart';
export 'package:mizer/protos/effects.pb.dart';

abstract class EffectsApi {
  Future<List<Effect>> getEffects();
  Future<void> addEffect(String name);
  Future<void> deleteEffect(int id);
  Future<void> updateEffectStep(UpdateEffectStepRequest updateEffectStepRequest);
}
