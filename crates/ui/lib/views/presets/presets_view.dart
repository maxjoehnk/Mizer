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
    return BlocBuilder<EffectsBloc, EffectState>(builder: (context, effects) {
      return BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
        return Column(children: [
          PresetGroup(
              label: "Groups",
              children: state.groups.map((group) => GroupButton(group: group)).toList()),
          PresetGroup(label: "Dimmer", children: [
            ...state.presets.intensities.map((preset) =>
                ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
            ...effects.getEffectsForControls([EffectControl.INTENSITY]).map(
                (effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Shutter", children: [
            ...state.presets.shutters.map((preset) =>
                ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
            ...effects.getEffectsForControls([EffectControl.SHUTTER]).map(
                (effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Color", children: [
            ...state.presets.colors.map((preset) => ColorButton(
                color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                    (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
                preset: preset)),
            ...effects.getEffectsForControls([
              EffectControl.COLOR_MIXER_BLUE,
              EffectControl.COLOR_MIXER_GREEN,
              EffectControl.COLOR_MIXER_RED,
              EffectControl.COLOR_WHEEL
            ]).map((effect) => EffectButton(effect: effect))
          ]),
          PresetGroup(label: "Position", children: [
            ...state.presets.positions.map((preset) => PositionButton(
                pan: preset.position.hasPan() ? preset.position.pan : null,
                tilt: preset.position.hasTilt() ? preset.position.tilt : null,
                preset: preset)),
            ...effects.getEffectsForControls([EffectControl.PAN, EffectControl.TILT]).map(
                (effect) => EffectButton(effect: effect))
          ]),
        ]);
      });
    });
  }
}
