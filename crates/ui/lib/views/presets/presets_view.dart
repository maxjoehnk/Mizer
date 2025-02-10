import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';

import 'preset_button.dart';
import 'preset_group.dart';

class PresetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EffectsBloc, EffectState>(
        builder: (context, effects) => BlocBuilder<PresetsBloc, PresetsState>(
            builder: (context, state) => ListView(children: [
                  PresetGroup(
                      label: "Groups",
                      child: PresetButtonList(
                          children:
                              state.groups.map((group) => GroupButton(group: group)).toList())),
                  PresetGroup(
                      label: "Dimmer",
                      child: PresetList(
                        presets: state.presets.intensities,
                        effects: effects.getEffectsForControls([EffectControl.INTENSITY]),
                      )),
                  PresetGroup(
                      label: "Shutter",
                      child: PresetList(
                        presets: state.presets.shutters,
                        effects: effects.getEffectsForControls([EffectControl.SHUTTER]),
                      )),
                  PresetGroup(
                      label: "Color",
                      child: PresetList(
                          presets: state.presets.colors,
                          effects: effects.getEffectsForControls([
                            EffectControl.COLOR_MIXER_BLUE,
                            EffectControl.COLOR_MIXER_GREEN,
                            EffectControl.COLOR_MIXER_RED,
                            EffectControl.COLOR_WHEEL
                          ]))),
                  PresetGroup(
                      label: "Position",
                      child: PresetList(
                        presets: state.presets.positions,
                        effects:
                            effects.getEffectsForControls([EffectControl.PAN, EffectControl.TILT]),
                      ))
                ])));
  }
}
