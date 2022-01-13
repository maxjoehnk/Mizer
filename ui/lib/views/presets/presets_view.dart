import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/groups.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/panel.dart';

class PresetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetsBloc, PresetsState>(
        builder: (context, state) {
          return Column(children: [
            GroupsPanel(state.groups),
            PresetGroup(
                label: "Dimmer",
                children: state.presets.intensities
                    .map((preset) =>
                        ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset))
                    .toList()),
            PresetGroup(
                label: "Color",
                children: state.presets.color
                    .map((preset) => ColorButton(
                        color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
                            (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
                        preset: preset))
                    .toList()),
          ]);
        });
  }
}

class PresetGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const PresetGroup({required this.label, required this.children, Key? key}) : super(key: key);

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
  final Preset preset;

  const PresetButton({required this.child, required this.preset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var programmerApi = context.read<ProgrammerApi>();
    var textTheme = Theme.of(context).textTheme;

    return Hoverable(
        onTap: () => programmerApi.callPreset(preset.id),
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
                      Text(preset.label),
                    ],
                  ),
                ),
                Align(
                    child: Text(preset.id.id.toString(), style: textTheme.bodySmall),
                    alignment: Alignment.topLeft)
              ],
            ),
          );
        });
  }
}
