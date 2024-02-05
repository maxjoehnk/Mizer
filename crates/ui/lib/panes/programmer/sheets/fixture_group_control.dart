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
import 'package:mizer/widgets/inputs/color.dart';
import 'package:mizer/widgets/inputs/encoder.dart';
import 'package:provider/provider.dart';

class Control {
  final String? label;
  final WriteControlRequest Function(dynamic) update;
  final FaderChannel? fader;
  final ColorMixerChannel? colorMixer;
  final AxisChannel? axis;
  final GenericChannel? generic;
  final ProgrammerChannel? channel;
  final List<ControlPreset>? presets;
  final FixtureControl control;

  Control(this.label,
      {required this.update,
      required this.control,
      this.fader,
      this.generic,
      this.colorMixer,
      this.axis,
      this.presets,
      required this.channel});

  bool get hasFader {
    return fader != null;
  }

  bool get hasGeneric {
    return generic != null;
  }

  bool get hasColor {
    return colorMixer != null;
  }

  bool get hasAxis {
    return axis != null;
  }

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
    Widget widget = Container();
    var presets = getPresets(context);
    if (control.hasFader || control.hasGeneric) {
      double? generic =
          control.channel?.hasGeneric() == true ? control.channel?.generic.value : null;
      widget = Container(
          width: 150,
          child: EncoderInput(
              label: control.label,
              globalPresets: presets,
              controlPresets: control.presets,
              value: control.channel?.fader ?? generic ?? 0,
              onValue: (v) => api.writeControl(control.update(v))));
    }
    if (control.hasColor) {
      ColorMixerChannel? color = control.channel?.color;
      widget = Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 150,
            margin: const EdgeInsets.only(right: 8),
            child: EncoderInput(
                label: "Red",
                globalPresets: presets,
                controlPresets: control.presets,
                value: color?.red ?? 0,
                onValue: (v) => api.writeControl(control.update(
                    ColorValue(red: v, green: color?.green ?? 0, blue: color?.blue ?? 0))))),
        Container(
            width: 150,
            margin: const EdgeInsets.only(right: 8),
            child: EncoderInput(
                label: "Green",
                globalPresets: presets,
                controlPresets: control.presets,
                value: color?.green ?? 0,
                onValue: (v) => api.writeControl(control
                    .update(ColorValue(red: color?.red ?? 0, green: v, blue: color?.blue ?? 0))))),
        Container(
            width: 150,
            margin: const EdgeInsets.only(right: 8),
            child: EncoderInput(
                label: "Blue",
                globalPresets: presets,
                controlPresets: control.presets,
                value: color?.blue ?? 0,
                onValue: (v) => api.writeControl(control
                    .update(ColorValue(red: color?.red ?? 0, green: color?.green ?? 0, blue: v))))),
      ]);
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
      child: widget,
    );
  }

  List<Preset>? getPresets(BuildContext context) {
    PresetsBloc presets = context.read();
    if (control.control == FixtureControl.INTENSITY) {
      return presets.state.getByPresetType(PresetType.Intensity);
    }
    if (control.control == FixtureControl.SHUTTER) {
      return presets.state.getByPresetType(PresetType.Shutter);
    }
    if (control.control == FixtureControl.COLOR_MIXER) {
      return presets.state.getByPresetType(PresetType.Color);
    }
    if (control.control == FixtureControl.PAN || control.control == FixtureControl.TILT) {
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
