import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/fixtures.pbenum.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';

import 'preset_button.dart';
import 'preset_group.dart';

class PresetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EffectsBloc, EffectState>(builder: (context, effects) {
      return BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
        return Column(children: [
          PresetGroup(
              label: "Groups",
              children: state.groups.map((group) => GroupButton(group: group)).toList()),
          PresetGroup(label: "Dimmer", children: [
            ...state.presets.intensities.map((preset) =>
                ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
            ...effects.getEffectsForControls([FixtureControl.INTENSITY]).map(
                (effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Shutter", children: [
            ...state.presets.shutters.map((preset) =>
                ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
            ...effects.getEffectsForControls([FixtureControl.SHUTTER]).map(
                (effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Color", children: [
            ...state.presets.colors.map((preset) => ColorButton(
                color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                    (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
                preset: preset)),
            ...effects.getEffectsForControls([
              FixtureControl.COLOR_MIXER,
              FixtureControl.COLOR_WHEEL
            ]).map((effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Position", children: [
            ...effects.getEffectsForControls([FixtureControl.PAN, FixtureControl.TILT]).map(
                (effect) => EffectButton(effect: effect))
          ]),
        ]);
      });
    });
  }
}
