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
            builder: (context, state) => Column(children: [
                  PresetGroup(
                      label: "Groups",
                      child: PresetButtonList(
                          children:
                              state.groups.map((group) => GroupButton(group: group)).toList())),
                  PresetGroup(
                      label: "Dimmer",
                      child: PresetList(
                        presets: state.presets.intensities,
                        effects: effects.getEffectsForControls(["Intensity"]),
                      )),
                  PresetGroup(
                      label: "Shutter",
                      child: PresetList(
                        presets: state.presets.shutters,
                        effects: effects.getEffectsForControls(["Shutter"]),
                      )),
                  PresetGroup(
                      label: "Color",
                      child: PresetList(
                          presets: state.presets.colors,
                          effects: effects.getEffectsForControls([
                            "ColorMixerRed",
                            "ColorMixerGreen",
                            "ColorMixerBlue",
                            "ColorWheel"
                          ]))),
                  PresetGroup(
                      label: "Position",
                      child: PresetList(
                        presets: state.presets.positions,
                        effects:
                            effects.getEffectsForControls(["Pan", "Tilt"]),
                      ))
                ])));
  }
}
