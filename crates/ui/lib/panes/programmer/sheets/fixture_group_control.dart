import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/preset_button.dart';
import 'package:mizer/views/presets/preset_group.dart';
import 'package:mizer/widgets/inputs/encoder.dart';
import 'package:provider/provider.dart';

class Control {
  final String? label;
  final WriteControlRequest Function(dynamic) update;
  final ProgrammerChannel? channel;
  final FixtureChannel control;
  final List<ControlPreset>? presets;

  Control(this.label,
      {required this.update,
      required this.control,
      this.presets,
      required this.channel});

  bool get hasPresets {
    return presets != null;
  }
}

class ControlPreset {
  final double value;
  final String name;
  final ControlPresetImage? image;
  late final List<Color>? colors;

  ControlPreset(this.value, {required this.name, this.image, List<String>? colors}) {
    if (colors != null) {
      this.colors = colors.map(fromCssColor).toList();
    } else {
      this.colors = null;
    }
  }

  @override
  String toString() {
    return "ControlPreset(value: $value, name: $name, image: $image, colors: $colors)";
  }
}

class ControlPresetImage {
  final String? svg;
  final Uint8List? raster;

  ControlPresetImage({this.svg, this.raster});
}

class FixtureGroupControl extends StatelessWidget {
  final Control control;
  final ProgrammerChannel? channel;
  final String? label;

  const FixtureGroupControl(this.control, {this.channel, this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgrammerApi api = context.read();
    var presets = getPresets(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
      child: Container(
        width: 150,
        child: EncoderInput(
            label: control.label,
            globalPresets: presets,
            controlPresets: control.presets,
            value: control.channel?.direct.percent ?? 0.0,
            onValue: (v) => api.writeControl(control.update(v)))),
    );
  }

  // TODO: This should reference an enum as well? Or maybe it should be returned by the proto api
  List<Preset>? getPresets(BuildContext context) {
    PresetsBloc presets = context.read();
    if (control.control == "Intensity") {
      return presets.state.getByPresetType(PresetType.Intensity);
    }
    if (control.control == "Shutter") {
      return presets.state.getByPresetType(PresetType.Shutter);
    }
    if (control.control == "ColorMixerRed") {
      return presets.state.getByPresetType(PresetType.Color);
    }
    if (control.control == "Pan" || control.control == "Tilt") {
      return presets.state.getByPresetType(PresetType.Position);
    }

    return null;
  }
}

class FixtureControlPresets extends StatelessWidget {
  final List<ControlPreset> presets;
  final Function(double) onSelect;

  const FixtureControlPresets(this.presets, {required this.onSelect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButtonList(
      children: presets
          .map((p) => PresetButton(
                label: p.name,
                onTap: () => onSelect(p.value),
                child: _child(context, p),
              ))
          .toList(),
    );
  }

  Widget _child(BuildContext context, ControlPreset preset) {
    if (preset.image != null) {
      return _image(preset.image!);
    }
    if (preset.colors != null && preset.colors!.isNotEmpty) {
      var colors = List.generate(preset.colors!.length, (index) {
        var color = preset.colors![index];
        return [color, color];
      }).flattened.toList();
      var stops = List.generate(preset.colors!.length, (index) => [index, index + 1])
          .flattened
          .map((index) => index / preset.colors!.length)
          .toList();
      var gradient = SweepGradient(colors: colors, stops: stops);
      return Container(
          decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle));
    }
    return Container();
  }

  Widget _image(ControlPresetImage image) {
    if (image.raster != null) {
      return Image.memory(image.raster!);
    } else {
      return SvgPicture.string(image.svg!, color: Colors.white);
    }
  }
}
