import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pbenum.dart';
import 'package:mizer/widgets/panel.dart';

import 'preset_button.dart';

enum PresetType {
  Dimmer,
  Color,
  Position,
}

class PresetGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const PresetGroup({required this.label, required this.children, Key? key}) : super(key: key);

  factory PresetGroup.build(String label, Presets presets, List<Effect> effects, PresetType type) {
    if (type == PresetType.Dimmer) {
      return PresetGroup(label: "Dimmer", children: [
        ...presets.intensities.map(
            (preset) => ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
        ...effects.getEffectsForControls([FixtureControl.INTENSITY]).map(
            (effect) => EffectButton(effect: effect))
      ]);
    }
    if (type == PresetType.Color) {
      return PresetGroup(label: "Color", children: [
        ...presets.colors.map((preset) => ColorButton(
            color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
            preset: preset)),
        ...effects
            .getEffectsForControls([FixtureControl.COLOR_MIXER, FixtureControl.COLOR_WHEEL]).map(
                (effect) => EffectButton(effect: effect))
      ]);
    }
    if (type == PresetType.Position) {
      return PresetGroup(label: "Position", children: [
        ...effects.getEffectsForControls([FixtureControl.PAN, FixtureControl.TILT]).map(
            (effect) => EffectButton(effect: effect))
      ]);
    }

    throw new Exception("Invalid PresetType");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Panel(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(spacing: 4, runSpacing: 4, children: children),
          ),
          label: label),
    );
  }
}

extension PresetEffects on List<Effect> {
  List<Effect> getEffectsForControls(List<FixtureControl> controls) {
    return this
        .where((effect) => effect.channels.any((c) => controls.contains(c.control)))
        .toList();
  }
}
