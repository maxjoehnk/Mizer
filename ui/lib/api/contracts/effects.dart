import 'package:mizer/protos/effects.pb.dart';
export 'package:mizer/protos/effects.pb.dart';

abstract class EffectsApi {
  Future<List<Effect>> getEffects();
}
