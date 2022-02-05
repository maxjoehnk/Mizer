import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class EffectsDemoApi implements EffectsApi {
  @override
  Future<List<Effect>> getEffects() async {
    return [
      Effect(id: 1, name: "Circle", steps: [
        EffectStep(channels: [
          EffectChannel(
            control: FixtureControl.PAN,
            value: CueValue(direct: 1)
          ),
          EffectChannel(
              control: FixtureControl.TILT,
              value: CueValue(direct: 0.5)
          ),
        ]),
        EffectStep(channels: [
          EffectChannel(
              control: FixtureControl.PAN,
              value: CueValue(direct: 0.5)
          ),
          EffectChannel(
              control: FixtureControl.TILT,
              value: CueValue(direct: 1)
          ),
        ]),
        EffectStep(channels: [
          EffectChannel(
              control: FixtureControl.PAN,
              value: CueValue(direct: 0)
          ),
          EffectChannel(
              control: FixtureControl.TILT,
              value: CueValue(direct: 0.5)
          ),
        ]),
        EffectStep(channels: [
          EffectChannel(
              control: FixtureControl.PAN,
              value: CueValue(direct: 0.5)
          ),
          EffectChannel(
              control: FixtureControl.TILT,
              value: CueValue(direct: 0)
          ),
        ]),
      ]),
      Effect(id: 2, name: "Square"),
      Effect(id: 3, name: "Eight"),
    ];
  }
}
