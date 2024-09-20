import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';
import 'package:mizer/widgets/panel.dart';

import 'preset_button.dart';

class PresetGroup extends StatelessWidget {
  final String label;
  final Widget child;

  const PresetGroup({required this.label, required this.child, Key? key}) : super(key: key);

  factory PresetGroup.build(String label, Presets presets, List<Effect> effects, PresetType type) {
    if (type == PresetType.Intensity) {
      return PresetGroup(
        label: "Dimmer",
        child: PresetList(
            presets: presets.intensities,
            effects: effects.getEffectsForControls(["Intensity"])),
      );
    }
    if (type == PresetType.Shutter) {
      return PresetGroup(
        label: "Shutter",
        child: PresetList(
            presets: presets.shutters,
            effects: effects.getEffectsForControls(["Shutter"])),
      );
    }
    if (type == PresetType.Color) {
      return PresetGroup(
          label: "Color",
          child: PresetList(
              presets: presets.colors,
              effects: effects.getEffectsForControls([
                "ColorMixerRed",
                "ColorMixerGreen",
                "ColorMixerBlue",
                "ColorWheel"
              ])));
    }
    if (type == PresetType.Position) {
      return PresetGroup(
          label: "Position",
          child: PresetList(
              presets: presets.positions,
              effects: effects.getEffectsForControls(["Pan", "Tilt"])));
    }

    throw new Exception("Invalid PresetType");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Panel(child: child, label: label),
    );
  }
}

class PresetButtonList extends StatelessWidget {
  final List<Widget> children;

  const PresetButtonList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(direction: Axis.horizontal, spacing: 4, runSpacing: 4, children: children),
      ),
    );
  }
}


class PresetList extends StatelessWidget {
  final List<Preset>? presets;
  final List<Effect>? effects;
  final void Function()? onSelect;

  const PresetList({super.key, this.effects, this.presets, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PresetButtonList(children: children);
  }

  List<Widget> get children {
    return [
      ...(presets ?? []).map((preset) => _presetButton(preset)),
      ...(effects ?? []).map((effect) => EffectButton(effect: effect)),
    ];
  }

  Widget _presetButton(Preset preset) {
    if (preset.hasColor()) {
      return ColorButton(
          color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
              (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
          preset: preset,
        onTap: onSelect,
      );
    }
    if (preset.hasFader()) {
      return ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset, onTap: onSelect);
    }
    if (preset.hasPosition()) {
      return PositionButton(pan: preset.position.pan, tilt: preset.position.tilt, preset: preset, onTap: onSelect);
    }

    return Container();
  }
}

extension PresetEffects on List<Effect> {
  List<Effect> getEffectsForControls(List<String> controls) {
    return this
        .where((effect) => effect.channels.any((c) => controls.contains(c.fixtureChannel)))
        .toList();
  }
}
