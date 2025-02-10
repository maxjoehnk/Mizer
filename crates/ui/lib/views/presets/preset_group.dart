import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_sizing.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';

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
            effects: effects.getEffectsForControls([EffectControl.INTENSITY])),
      );
    }
    if (type == PresetType.Shutter) {
      return PresetGroup(
        label: "Shutter",
        child: PresetList(
            presets: presets.shutters,
            effects: effects.getEffectsForControls([EffectControl.SHUTTER])),
      );
    }
    if (type == PresetType.Color) {
      return PresetGroup(
          label: "Color",
          child: PresetList(
              presets: presets.colors,
              effects: effects.getEffectsForControls([
                EffectControl.COLOR_MIXER_BLUE,
                EffectControl.COLOR_MIXER_GREEN,
                EffectControl.COLOR_MIXER_RED,
                EffectControl.COLOR_WHEEL
              ])));
    }
    if (type == PresetType.Position) {
      return PresetGroup(
          label: "Position",
          child: PresetList(
              presets: presets.positions,
              effects: effects.getEffectsForControls([EffectControl.PAN, EffectControl.TILT])));
    }

    throw new Exception("Invalid PresetType");
  }

  @override
  Widget build(BuildContext context) {
    return PanelSizing(
      rows: 2.6,
      child: Panel(
        label: label,
        child: child,
      ),
    );
  }
}

class PresetButtonList extends StatelessWidget {
  final List<Widget> children;

  const PresetButtonList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return PanelGrid(children: [
      ...children,
      ...List.filled(40, PanelGridTile.empty()),
    ]);
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
  List<Effect> getEffectsForControls(List<EffectControl> controls) {
    return this
        .where((effect) => effect.channels.any((c) => controls.contains(c.control)))
        .toList();
  }
}
