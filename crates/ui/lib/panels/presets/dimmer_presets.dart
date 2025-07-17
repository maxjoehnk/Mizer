import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/effects.pbenum.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/preset_group.dart';

class DimmerPresetsPanel extends StatelessWidget {
  const DimmerPresetsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EffectsBloc, EffectState>(
        builder: (context, effects) =>
            BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
              return PresetGroup(
                  label: "Dimmer",
                  child: PresetList(
                    fill: true,
                    presets: state.presets.intensities,
                    effects: effects.getEffectsForControls([EffectControl.INTENSITY]),
                  ));
            }));
  }
}
