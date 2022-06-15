import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pbenum.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/groups.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/panel.dart';

class PresetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EffectsBloc, EffectState>(
      builder: (context, effects) {
        return BlocBuilder<PresetsBloc, PresetsState>(
            builder: (context, state) {
              return Column(children: [
                GroupsPanel(state.groups),
                PresetGroup(
                    label: "Dimmer",
                    children: [
                      ...state.presets.intensities
                        .map((preset) =>
                            ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
                      ...effects.getEffectsForControls([FixtureControl.INTENSITY]).map((effect) => EffectButton(effect: effect))
                    ]),
                PresetGroup(
                    label: "Color",
                    children: [
                      ...state.presets.color
                        .map((preset) => ColorButton(
                            color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                                (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
                            preset: preset)),
                      ...effects.getEffectsForControls([FixtureControl.COLOR_MIXER, FixtureControl.COLOR_WHEEL]).map((effect) => EffectButton(effect: effect))
                      ]),
                PresetGroup(
                    label: "Position",
                    children: [
                      ...effects.getEffectsForControls([FixtureControl.PAN, FixtureControl.TILT]).map((effect) => EffectButton(effect: effect))
                    ]),
              ]);
            });
      }
    );
  }
}

class EffectButton extends StatelessWidget {
  final Effect effect;

  const EffectButton({ required this.effect, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButton(
        child: Container(
          width: 48,
          height: 48,
          child: Center(child: Icon(MdiIcons.sineWave, size: 32)),
        ),
        effect: effect);
  }
}

enum PresetType {
  Dimmer,
  Color,
  Position,
}

const PRESET_TYPES = {
  FixtureControl.INTENSITY: PresetType.Dimmer,
  FixtureControl.COLOR_WHEEL: PresetType.Color,
  FixtureControl.COLOR_MIXER: PresetType.Color,
  FixtureControl.PAN: PresetType.Position,
  FixtureControl.TILT: PresetType.Position,
};

class PresetGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const PresetGroup({required this.label, required this.children, Key? key}) : super(key: key);

  factory PresetGroup.build(String label, Presets presets, List<Effect> effects, PresetType type) {
    if (type == PresetType.Dimmer) {
      return PresetGroup(
          label: "Dimmer",
          children: [
            ...presets.intensities
                .map((preset) =>
                ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset)),
            ...effects.getEffectsForControls([FixtureControl.INTENSITY]).map((effect) => EffectButton(effect: effect))
          ]);
    }
    if (type == PresetType.Color) {
      return PresetGroup(
          label: "Color",
          children: [
            ...presets.color
                .map((preset) => ColorButton(
                color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                    (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
                preset: preset)),
            ...effects.getEffectsForControls([FixtureControl.COLOR_MIXER, FixtureControl.COLOR_WHEEL]).map((effect) => EffectButton(effect: effect))
          ]);
    }
    if (type == PresetType.Position) {
      return PresetGroup(
          label: "Position",
          children: [
            ...effects.getEffectsForControls([FixtureControl.PAN, FixtureControl.TILT]).map((effect) => EffectButton(effect: effect))
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

class ColorButton extends StatelessWidget {
  final Color color;
  final Preset preset;

  const ColorButton({required this.color, required this.preset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButton(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
        ),
        preset: preset);
  }
}

class PresetButton extends StatelessWidget {
  final Widget child;
  final Preset? preset;
  final Effect? effect;

  PresetButton({required this.child, this.preset, this.effect, Key? key}) : super(key: key) {
    assert(effect != null || preset != null);
  }

  @override
  Widget build(BuildContext context) {
    var programmerApi = context.read<ProgrammerApi>();
    var textTheme = Theme.of(context).textTheme;

    return Hoverable(
        onTap: () {
          if (preset != null) {
            programmerApi.callPreset(preset!.id);
          }
          if (effect != null) {
            programmerApi.callEffect(effect!.id);
          }
        },
        builder: (hovered) {
          return Container(
            width: 72,
            decoration: ControlDecoration(color: Colors.black, highlight: hovered),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      child,
                      Text(label, style: textTheme.bodySmall, overflow: TextOverflow.clip, maxLines: 1),
                    ],
                  ),
                ),
                Align(
                    child: Text("${preset == null ? "E" : "P"}$id", style: textTheme.bodySmall),
                    alignment: Alignment.topLeft)
              ],
            ),
          );
        });
  }

  String get label {
    return effect?.name ?? preset!.label;
  }

  int get id {
    return effect?.id ?? preset!.id.id;
  }
}

extension PresetEffects on List<Effect> {
  List<Effect> getEffectsForControls(List<FixtureControl> controls) {
    return this.where((effect) => effect.channels.any((c) => controls.contains(c.control))).toList();
  }
}
