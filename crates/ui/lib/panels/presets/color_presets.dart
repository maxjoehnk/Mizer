import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/effects.pbenum.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/preset_group.dart';

class ColorPresetsPanel extends StatelessWidget {
  const ColorPresetsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EffectsBloc, EffectState>(
        builder: (context, effects) =>
            BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
              return PresetGroup(
                  label: "Color",
                  child: PresetList(
                      fill: true,
                      presets: state.presets.colors,
                      effects: effects.getEffectsForControls([
                        EffectControl.COLOR_MIXER_BLUE,
                        EffectControl.COLOR_MIXER_GREEN,
                        EffectControl.COLOR_MIXER_RED,
                        EffectControl.COLOR_WHEEL
                      ])));
            }));
  }
}
